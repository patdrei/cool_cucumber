class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def show
    @recipe = Recipe.find(params[:id])
    @all_recipe_ingredients = @recipe.recipe_ingredients
  end

  def remove_html_tags(input)
    re = /<("[^"]*"|'[^']*'|[^'">])*>/
    self.input.gsub!(re, '')
  end

end


