class InventoriesController < ApplicationController
  before_action :require_user

  def index
    @inventories = Inventory.all
  end

  def edit
    @inventory = Inventory.find(params[:id])
  end

  def update
    @inventory = Inventory.find(params[:id])
    if @inventory.update(quantity_inventory: @inventory.quantity_inventory + params.require(:inventory).permit(:quantity_inventory)[:quantity_inventory].to_f)
      flash[:notice] = 'Inventory updated'
      redirect_to inventories_path
    else
      flash[:notice] = "There's been an error. Remember to use only numbers (positive or negative)"
      redirect_to inventories_path
    end
  end
end
