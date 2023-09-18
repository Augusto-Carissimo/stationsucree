# frozen_string_literal: true

class IngredientsController < ApplicationController

  def index
    @ingredients = Ingredient.all
  end

  def show
    @ingredient = Ingredient.find(params[:id])
  end

  def new
    @ingredient = Ingredient.new
  end

  def edit
    @ingredient = Ingredient.find(params[:id])
  end

  def create
    @ingredient = Ingredient.new(params.require(:ingredient).permit(:name_ingredient, :last_price))
    if @ingredient.save
      redirect_to ingredients_path
    else
      flash[:notice] = I18n.t 'error'
      render 'new'
    end
  end

  def update
    @ingredient = Ingredient.find(params[:id])
    if params[:commit] == 'Add'
      add_ingredient_quantity
    else
      edit_ingredient_info
    end
    redirect_to ingredients_path
  end

  def destroy
    @ingredient = Ingredient.find(params[:id])
    @ingredient.destroy
    redirect_to ingredients_path
  end

  private

  def add_ingredient_quantity
    update_quantity = (@ingredient.quantity_ingredient + params[:ingredient][:quantity_ingredient].to_f).round(2)
    flash.now[:notice] = if @ingredient.update(quantity_ingredient: update_quantity)
                           I18n.t 'ia'
                         else
                           I18n.t 'error'
                         end
  end

  def edit_ingredient_info
    flash.now[:notice] = if @ingredient.update(params.require(:ingredient).permit(:name_ingredient, :last_price))
                           I18n.t 'iu'
                         else
                           I18n.t 'error'
                         end
  end
end
