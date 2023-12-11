# frozen_string_literal: true

class RecipesController < ApplicationController
  before_action :require_user
  before_action :set_recipe, only: %i[show edit update destroy]

  def index
    @recipes = Recipe.all
  end

  def show
    @ingredient_recipes = @recipe.ingredient_recipes#.order(name_ingredient: :asc)
    @subproduct_recipes = @recipe.subproduct_recipes#.order(product_name: :asc)
  end

  def new
    @recipe = Recipe.new
    @ingredients = Ingredient.all.order(name_ingredient: :asc)
    @subproducts = Product.where(is_subproduct: true).order(name_product: :asc)
  end

  def edit
    @ingredients = Ingredient.all.order(name_ingredient: :asc)
    @subproducts = Product.where(is_subproduct: true).order(name_product: :asc)
  end

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
    params[:recipe].each do |ingredient_name, quantity|
      if quantity.to_d.negative?
        flash[:notice] = I18n.t 'rcnm'
      elsif ingredient = Ingredient.find_by(name_ingredient: ingredient_name)
        if ingredient_recipe = @recipe.ingredient_recipes.find_by(ingredient:)
          if quantity.to_d == 0.0
            ingredient_recipe.destroy
          elsif quantity.to_d > 0.0
            ingredient_recipe.update(quantity_recipe: quantity)
          end
        else
          if quantity.to_d > 0.0
            @recipe.ingredient_recipes.create(ingredient:, quantity_recipe: quantity)
          end
        end
      else
        if product = Product.find_by(name_product: ingredient_name)
          if subproduct_recipe = @recipe.subproduct_recipes.find_by(product:)
            if quantity.to_d == 0.0
              subproduct_recipe.destroy
            elsif quantity.to_d > 0.0
              subproduct_recipe.update(quantity_recipe: quantity)
            end
          elsif quantity.to_d > 0.0
            @recipe.subproduct_recipes.create(product:, quantity_recipe: quantity)
          end
        end
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
