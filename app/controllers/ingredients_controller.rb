class IngredientsController < ApplicationController
  before_action :require_user

  def index
    @ingredients = Ingredient.all
  end
  def show
    @ingredient = Ingredient.find(params[:id])
  end

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(params.require(:ingredient).permit(
      :name_ingredient, :last_price))
    if @ingredient.save
      redirect_to ingredients_path
    else
      flash[:notice] = "There's been an error."
      render 'new'
    end
  end

  def edit
    @ingredient = Ingredient.find(params[:id])
  end

  def update
    @ingredient = Ingredient.find(params[:id])
    if params[:commit] == 'Add'
      add_ingredient_quantity
    else
      edit_ingredient_info
    end
  end

  def destroy
    @ingredient = Ingredient.find(params[:id])
    @ingredient.destroy
    redirect_to ingredients_path
  end

  private

  def error_messagge
    flash[:notice] = "There's been an error."
    redirect_to ingredients_path
  end

  def add_ingredient_quantity
    update_quantity = (@ingredient.quantity_ingredient + params[:ingredient][:quantity_ingredient].to_f).round(2)
    if @ingredient.update(quantity_ingredient: update_quantity)
      flash[:notice] = 'Ingredient added'
      redirect_to ingredients_path
    else
      error_messagge
    end
  end

  def edit_ingredient_info
    if @ingredient.update(params.require(:ingredient).permit(:name_ingredient, :last_price))
      flash[:notice] = 'Ingredient updated'
      redirect_to ingredients_path
    else
      error_messagge
    end
  end
end
