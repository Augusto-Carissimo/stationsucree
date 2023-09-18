# frozen_string_literal: true

class ProductsController < ApplicationController # rubocop:disable Metrics/ClassLength: Class has too many lines
  before_action :set_product, only: %i[show edit update destroy]

  def index
    @products = Product.all
  end

  def show; end

  def new
    @product = Product.new
  end

  def edit; end

  def create
    @product = Product.new(params.require(:product).permit(:name_product, :quantity_product, :recipe_text,
                                                           :is_subproduct))
    if @product.save
      create_stock_per_location(@product)
      flash[:notice] = "Created #{@product.name_product} successfully, please add recipe."
      redirect_to new_recipe_path
    else
      flash[:notice] = I18n.t 'error'
      render 'new'
    end
  end

  def update
    if params[:commit] == 'Edit product'
      edit_product
    else
      produce_product
    end
    redirect_to products_path
  end

  def destroy
    @product.destroy
    redirect_to products_path
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def quantity_params
    params.require(:product).permit(:quantity_product)[:quantity_product].to_f
  end

  def create_stock_per_location(product)
    Location.all.each do |location|
      StockPerLocation.create!(product_id: product.id, location_id: location.id)
    end
  end

  def edit_product
    flash.now[:notice] = if @product.update(params.require(:product).permit(:name_product, :recipe_text,
                                                                            :is_subproduct))
                           I18n.t 'pu'
                         else
                           I18n.t 'error'
                         end
  end

  def produce_product # rubocop:disable Metrics/AbcSize
    if check_availability_ingredients.any?
      flash[:notice] = "There's not enough #{check_availability_ingredients.each {}}" # empty block
    elsif @product.update(quantity_product: @product.quantity_product + quantity_params) && consume_recipe_ingredients
      flash[:notice] = I18n.t 'pu'
    else
      flash[:notice] = I18n.t 'error'
    end
  end

  def check_availability_ingredients
    missing_ingredients = []
    check_ingredients(missing_ingredients)
    check_subproducts(missing_ingredients)
    missing_ingredients
  end

  def check_ingredients(missing_ingredients)
    @product.recipe.ingredient_recipes.each do |ingredient_recipe|
      necessary_amount = ingredient_recipe.quantity_recipe * quantity_params
      available_amount = ingredient_recipe.ingredient.quantity_ingredient
      missing_ingredients << ingredient_recipe.ingredient.name_ingredient if necessary_amount > available_amount
    end
  end

  def check_subproducts(missing_ingredients)
    @product.recipe.subproduct_recipes.each do |subproduct_recipe|
      necessary_amount = subproduct_recipe.quantity_recipe * quantity_params
      available_amount = subproduct_recipe.product.quantity_product
      missing_ingredients << subproduct_recipe.product.name_product if necessary_amount > available_amount
    end
  end

  def consume_recipe_ingredients
    consume_ingredients
    consume_subproducts
  end

  def consume_ingredients
    @product.recipe.ingredient_recipes.each do |ingredient_recipe|
      ingredient = Ingredient.find(ingredient_recipe.ingredient.id)
      consume_quantity = (ingredient_recipe.quantity_recipe * quantity_params)
      ingredient.update(quantity_ingredient: (ingredient.quantity_ingredient - consume_quantity).round(2))
    end
  end

  def consume_subproducts
    @product.recipe.subproduct_recipes.each do |subproduct_recipe|
      product = Product.find(subproduct_recipe.product.id)
      consume_quantity = (subproduct_recipe.quantity_recipe * quantity_params)
      product.update(quantity_product: (product.quantity_product - consume_quantity).round(2))
    end
  end
end
