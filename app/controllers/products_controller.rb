class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(quantity: @product.quantity + params.require(:product).permit(:quantity)[:quantity].to_i)
      flash[:notice] = 'Product updated'
      redirect_to products_path
    else
      flash[:notice] = "There's been an error."
      redirect_to products_path
    end
  end

  def edit
    @product = Product.find(params[:id])
  end
end
