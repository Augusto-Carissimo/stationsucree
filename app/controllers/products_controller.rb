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

  def create
    @product = Product.new(params.require(:product).permit(:name_product, :quantity_product, :recipe_text))
    if @product.save
      Location.all.each do |location|
        StockPerLocation.create!(product_id: @product.id, location_id: location.id)
      end
      redirect_to products_path
    else
      flash[:notice] = "There's been an error."
      render 'new'
    end
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(quantity_product: @product.quantity_product + params.require(:product).permit(:quantity_product)[:quantity_product].to_i)
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

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path
  end
end
