class IngredientsController < ApplicationController
  def show
    @ingredient = Ingredient.find(params[:id])
  end

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(params.require(:ingredient).permit(
      :name_ingredient, :attr_1, :attr_2, :attr_3,:exparation_date, :last_price))
    if @ingredient.save
      Inventory.create!(ingredient_id: @ingredient.id, quantity_inventory: 1)
      redirect_to inventories_path
    else
      flash[:notice] = "There's been an error."
      render 'new'
    end
  end

  def destroy
    @ingredient = Ingredient.find(params[:id])
    @ingredient.destroy
    redirect_to inventories_path
  end
end
