class StockPerLocationsController < ApplicationController
  before_action :require_user

  def edit
    @stock = StockPerLocation.find(params[:id])
  end

  def update
    @stock = StockPerLocation.find(params[:id])
    if params[:commit] == 'Sold'
      sold_product
    else
      transfer_from_lab
    end
  end

  private

  def stock_update_params
    params.require(:stock_per_location).permit(:quantity_stock)[:quantity_stock].to_i
  end

  def sold_product
    if @stock.update(quantity_stock: @stock.quantity_stock - stock_update_params)
      flash[:notice] = 'Stock updated'
      redirect_to locations_path
    else
      error_messagge
    end
  end

  def transfer_from_lab
    if check_product_quantity >= stock_update_params && @stock.update(quantity_stock: @stock.quantity_stock + stock_update_params)
      flash[:notice] = 'Stock updated'
      subtract_from_lab
      redirect_to locations_path
    else
      error_messagge
    end
  end

  def subtract_from_lab
    product = Product.find(@stock.product.id)
    product.update(quantity_product: product.quantity_product - stock_update_params)
  end

  def check_product_quantity
    Product.find(@stock.product.id).quantity_product
  end

  def error_messagge
    flash[:notice] = "There's been an error"
    redirect_to locations_path
  end
end
