class ProductsController < ApplicationController
  before_action :require_user

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params.require(:product).permit(:name_product, :quantity_product, :recipe_text, :is_subproduct))
    if @product.save
      Location.all.each do |location|
        StockPerLocation.create!(product_id: @product.id, location_id: location.id)
      end
      redirect_to products_path
    else
      flash[:notice] = "There's been an error."
      render 'new'
    end
  end

  def update
    @product = Product.find(params[:id])
    if params[:commit] == 'Edit product'
      update_name_and_recipe
    else
      update_quantity
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path
  end

  private

  def quantity_params
    params.require(:product).permit(:quantity_product)[:quantity_product].to_f
  end

  def product_with_recipe
    @prod_join ||= Product.distinct(:id).where(id: @product.id).joins(recipe: :ingredient_recipes).first
  end

  def update_name_and_recipe
    if @product.update(params.require(:product).permit(:name_product, :recipe_text))
      successful_message
    else
      error_message
    end
  end

  def update_quantity
    if check_availability_ingredients.any?
      flash[:notice] = "There's not enough #{check_availability_ingredients.each { |ing| ing } } "
      redirect_to products_path
    else
      if @product.update(quantity_product: @product.quantity_product + quantity_params) && consume_ingredients
        successful_message
      else
        error_message
      end
    end
  end

  def check_availability_ingredients
    missing_ingredients = []
    product_with_recipe.recipe.ingredient_recipes.each do |ingredient_recipe|
      necessary_amount = ingredient_recipe.quantity_recipe * quantity_params
      available_amount = ingredient_recipe.ingredient.inventory.quantity_inventory
      if necessary_amount > available_amount
        missing_ingredients << ingredient_recipe.ingredient.name_ingredient
      end
    end
    missing_ingredients
  end

  def consume_ingredients
    product_with_recipe.recipe.ingredient_recipes.each do |ingredient_recipe|
      Inventory.find(ingredient_recipe.ingredient.inventory.id).update(quantity_inventory: ingredient_recipe.ingredient.inventory.quantity_inventory - (ingredient_recipe.quantity_recipe * quantity_params))
    end
  end

  def successful_message
    flash[:notice] = 'Product updated'
    redirect_to products_path
  end

  def error_message
    flash[:notice] = "There's been an error."
    redirect_to products_path
  end
end
