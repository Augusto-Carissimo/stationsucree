class StockPerLocationsController < ApplicationController

  def edit
    @stock = StockPerLocation.find(params[:id])
  end

  def update
    @stock = StockPerLocation.find(params[:id])
    if params[:commit] == 'Sold'
      sold
    else
      transfer
    end
  end

  private

  def stock_update_params
    params.require(:stock_per_location).permit(:quantity_stock)[:quantity_stock].to_i
  end

  def sold
    if @stock.update(quantity_stock: @stock.quantity_stock - stock_update_params)
      flash[:notice] = 'Stock updated'
      redirect_to locations_path
    else
      flash[:notice] = "There's been an error"
      redirect_to locations_path
    end
  end

  def transfer
    if @stock.update(quantity_stock: @stock.quantity_stock + stock_update_params)
      flash[:notice] = 'Stock updated'
      product = Product.find(@stock.product.id)
      product.update(quantity_product: product.quantity_product - stock_update_params)
      redirect_to locations_path
    else
      flash[:notice] = "There's been an error"
      redirect_to locations_path
    end
  end
end
