class Api::ProductsController < ApplicationController
  before_action :set_api_product, only: [:show, :update, :destroy]

  # GET /api/products
  def index
    @api_products = if params[:name]
                      Api::Product.where('name ILIKE ?', "%#{params[:name]}%")
                    else
                      Api::Product.all
                    end

    render json: @api_products
  end

  # GET /api/products/1
  def show
    render json: @api_product
  end

  # POST /api/products
  def create
    @api_product = Api::Product.new(api_product_params)

    if @api_product.save
      render json: @api_product, status: :created, location: @api_product
    else
      render json: @api_product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/products/1
  def update
    if @api_product.update(api_product_params)
      render json: @api_product
    else
      render json: @api_product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/products/1
  def destroy
    @api_product.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_api_product
    @api_product = Api::Product.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def api_product_params
    params.require(:api_product).permit(:name)
  end
end
