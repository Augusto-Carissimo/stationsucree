# frozen_string_literal: true

class IngredientsController < ApplicationController
  before_action :require_user
  before_action :set_ingredient, only: %i[show edit update destroy]

  def index
    @ingredients = Ingredient.all.order(name_ingredient: :asc)
  end

  def show; end

  def new
    @ingredient = Ingredient.new
  end

  def edit; end

  def create
    @ingredient = Ingredient.new(params.require(:ingredient).permit(:name_ingredient, :last_price, :unit, :quantity_per_unit))
    if @ingredient.save
      PriceHistory.create!(ingredient_id: @ingredient.id, price: params[:ingredient][:last_price].to_d )
      redirect_to ingredients_path
    else
      flash[:notice] = I18n.t 'error'
      render 'new'
    end
  end

  def update
    if params[:commit] == 'Add'
      add_ingredient_quantity
    else
      edit_ingredient_info
      PriceHistory.create!(ingredient_id: @ingredient.id, price: params[:ingredient][:last_price].to_d )
    end
    redirect_to ingredients_path
  end

  def destroy
    @ingredient.destroy
    redirect_to ingredients_path
  end

  private

  def set_ingredient
    @ingredient = Ingredient.find(params[:id])
  end

  def add_ingredient_quantity
    update_quantity = (@ingredient.quantity_ingredient + params[:ingredient][:quantity_ingredient].to_d)
    flash.now[:notice] = if @ingredient.update(quantity_ingredient: update_quantity)
                           I18n.t 'ia'
                         else
                           I18n.t 'error'
                         end
  end

  def edit_ingredient_info
    flash.now[:notice] = if @ingredient.update(params.require(:ingredient).permit(:name_ingredient, :last_price, :unit, :quantity_per_unit))
                           I18n.t 'iu'
                         else
                           I18n.t 'error'
                         end
  end
end
