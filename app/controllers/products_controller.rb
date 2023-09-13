class ProductsController < ApplicationController
  before_action :require_user
  before_action :set_products, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all
  end

  def show; end

  def new
    @product = Product.new
  end

  def edit; end

  def create
    @product = Product.new(params.require(:product).permit(:name_product, :quantity_product, :recipe_text, :is_subproduct))
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
    if @product.update(params.require(:product).permit(:name_product, :recipe_text, :is_subproduct))
      flash[:notice] = I18n.t 'pu'
    else
      flash[:notice] = I18n.t 'error'
    end
    redirect_to products_path
  end

  def produce_product
    if check_availability_ingredients.any?
      flash[:notice] = "There's not enough #{check_availability_ingredients.each { _ }} "
    else
      if @product.update(quantity_product: @product.quantity_product + quantity_params) && consume_recipe_ingredients
        flash[:notice] = I18n.t 'pu'
      else
        flash[:notice] = I18n.t 'error'
      end
    end
    redirect_to products_path
  end

  def check_availability_ingredients
    missing_ingredients = []
    check_ingredients
    check_subproducts
    missing_ingredients
  end

  def check_ingredients
    @product.recipe.ingredient_recipes.each do |ingredient_recipe|
      necessary_amount = ingredient_recipe.quantity_recipe * quantity_params
      available_amount = ingredient_recipe.ingredient.quantity_ingredient
      missing_ingredients << ingredient_recipe.ingredient.name_ingredient if necessary_amount > available_amount
    end
  end

  def check_subproducts
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
      update_quantity = (ingredient_recipe.ingredient.quantity_ingredient - (ingredient_recipe.quantity_recipe * quantity_params)).round(2)
      Ingredient.find(ingredient_recipe.ingredient.id).update(quantity_ingredient: update_quantity)
    end
  end

  def consume_subproducts
    @product.recipe.subproduct_recipes.each do |subproduct_recipe|
      update_quantity = (subproduct_recipe.product.quantity_product - (subproduct_recipe.quantity_recipe * quantity_params)).round(2)
      Product.find(subproduct_recipe.product.id).update(quantity_product: update_quantity)
    end
  end
end
