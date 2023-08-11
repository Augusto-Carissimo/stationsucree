class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new()
    @ingredients = Ingredient.all
  end

  def create
    @recipe = Recipe.new(params.require(:recipe).permit(:product_id))
    if @recipe.save
      params[:recipe].each do |param|
        if param[0] != 'product_id' && param[1].to_f > 0
          IngredientRecipe.create!(recipe: @recipe, ingredient_id: param[0], quantity_recipe: param[1])
        end
      end
      flash[:notice] = 'Recipe created'
      redirect_to recipes_path
    else
      flash[:notice] = "There's been an error"
      render 'new'
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end
end
