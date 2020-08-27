class RecipesController < ApplicationController

  def show
    @recipe = Recipe.find(params[:id])
    @all_recipe_ingredients = @recipe.recipe_ingredients
  end
end


