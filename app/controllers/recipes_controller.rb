class RecipesController < ApplicationController
  before_action :require_user

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new()
    @ingredients = Ingredient.all
    @subproducts = Product.where(is_subproduct: true)
  end

  def create
    @recipe = Recipe.new(params.require(:recipe).permit(:product_id))
    if @recipe.save
      params[:recipe].each do |param|
        if param[0] != 'product_id' && param[1].to_f > 0
          if ingredient = Ingredient.find_by(name_ingredient: param[0])
            IngredientRecipe.create!(
              recipe: @recipe, ingredient: ingredient, quantity_recipe: param[1])
          else
            SubproductRecipe.create!(
              recipe: @recipe, product: Product.find_by(name_product: param[0]), quantity_recipe: param[1])
          end
        end
      end
      flash[:notice] = 'Recipe created'
      redirect_to recipes_path
    else
      flash[:notice] = "Please select Product"
      redirect_to new_recipe_path
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    params[:recipe].each do |param|
      if ingredient = Ingredient.find_by(name_ingredient: param[0])
        @recipe.ingredient_recipes.find_by(ingredient: ingredient).update(quantity_recipe: param[1])
      else
        product = Product.find_by(name_product: param[0])
        @recipe.subproduct_recipes.find_by(product: product).update(quantity_recipe: param[1])
      end
    end
    redirect_to recipe_path(@recipe)
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end
end
