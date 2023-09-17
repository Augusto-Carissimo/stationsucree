# frozen_string_literal: true

class RecipesController < ApplicationController
  before_action :require_user
  before_action :set_recipe, only: %i[show edit update destroy]

  def index
    @recipes = Recipe.all
  end

  def show; end

  def new
    @recipe = Recipe.new
    @ingredients = Ingredient.all
    @subproducts = Product.where(is_subproduct: true)
  end

  def edit; end

  def create # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    @recipe = Recipe.new(params.require(:recipe).permit(:product_id))
    if @recipe.save
      params[:recipe].each do |param|
        create_recipe_structure(param)
      end
      flash[:notice] = I18n.t 'rc'
      redirect_to recipes_path
    else
      flash[:notice] = I18n.t 'psp'
      redirect_to new_recipe_path
    end
  end

  def update # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    params[:recipe].each do |param|
      if param[1].to_f.negative?
        flash[:notice] = I18n.t 'rcnm'
      elsif (ingredient = Ingredient.find_by(name_ingredient: param[0]))
        @recipe.ingredient_recipes.find_by(ingredient:).update(quantity_recipe: param[1])
      else
        product = Product.find_by(name_product: param[0])
        @recipe.subproduct_recipes.find_by(product:).update(quantity_recipe: param[1])
      end
    end
    redirect_to recipe_path(@recipe)
  end

  def destroy
    @recipe.destroy
    redirect_to recipes_path
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def create_recipe_structure(param)
    return unless param[0] != 'product_id' && param[1].to_f.positive?

    if (ingredient = Ingredient.find_by(name_ingredient: param[0]))
      IngredientRecipe.create!(recipe: @recipe, ingredient:, quantity_recipe: param[1])
    else
      product = Product.find_by(name_product: param[0])
      SubproductRecipe.create!(recipe: @recipe, product:, quantity_recipe: param[1])
    end
  end
end
