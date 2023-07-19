class InventoriesController < ApplicationController
  def index
    @inventories = Inventory.all
  end

  def edit
    @inventory = Inventory.find(params[:id])
  end

  def update
    @inventory = Inventory.find(params[:id])
    if @inventory.update(quantity: @inventory.quantity + params.require(:inventory).permit(:quantity)[:quantity].to_i)
      flash[:notice] = 'Inventory updated'
      redirect_to inventories_path
    else
      flash[:notice] = "There's been an error. Remember to use only numbers (positive or negative)"
      redirect_to inventories_path
    end
  end
end
