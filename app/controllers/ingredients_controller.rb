class IngredientsController < ApplicationController
  def show
    @ingredient = Ingredient.find(params[:id])
  end

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.create(params.require(:ingredient).permit(:name_ingredient, :attr_1, :attr_2, :attr_3,:exparation_date, :last_price))
    if @ingredient
      redirect_to ingredient_path(@ingredient)
    else
      render 'new'
    end
  end
end
