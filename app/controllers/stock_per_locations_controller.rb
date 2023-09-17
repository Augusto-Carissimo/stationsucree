# frozen_string_literal: true

class StockPerLocationsController < ApplicationController
  before_action :require_user

  def update
    @stock = StockPerLocation.find(params[:id])
    if params[:commit] == 'Sold'
      sold_product
    else
      transfer_from_lab
    end
    redirect_to location_path(@stock.location)
  end

  private

  def stock_update_params
    params.require(:stock_per_location).permit(:quantity_stock)[:quantity_stock].to_i
  end

  def sold_product
    flash.now[:notice] = if @stock.update(quantity_stock: @stock.quantity_stock - stock_update_params)
                           I18n.t 'su'
                         else
                           I18n.t 'error'
                         end
  end

  def transfer_from_lab
    if check_product_quantity >= stock_update_params && @stock.update(
      quantity_stock: @stock.quantity_stock + stock_update_params
    )
      flash[:notice] = I18n.t 'su'
      subtract_from_lab
    else
      flash[:notice] = I18n.t 'error'
    end
  end

  def subtract_from_lab
    product = Product.find(@stock.product.id)
    product.update(quantity_product: product.quantity_product - stock_update_params)
  end

  def check_product_quantity
    Product.find(@stock.product.id).quantity_product
  end
end
