class ShoppingListItemsController < ApplicationController
  def index
    @meal_plan = MealPlan.find(params[:meal_plan_id])
    @shopping_list_items = @meal_plan.shopping_list_items
  end

  def create_shopping_list_items
    # create shopping list item
    # pass in ingredients  through the recipe_ingredients
    # same for amount
    # set purchased to true
    # check if any of those already exist
    @meal_plan = MealPlan.find(params[:meal_plan_id])
    @meal_plan.meals.each do |meal|
      @recipes = meal.recipes
      unless @meal_plan.shopping_list_items.exists?(@recipe.recipe_ingredient.ingredient_id)
        unless ShoppingListItem.exists?(ingredient_id: @recipe.recipe_ingredient.ingredient_id, meal_plan_id: @meal_plan)
          @recipes.recipe_ingredients.each do |recipe_ingredient|
            ShoppingListItem.create(
              ingredient_id: @recipe.recipe_ingredient.ingredient_id,
              amount: @recipe_ingredient.amount,
              purchased: false,
              meal_plan_id: params[:meal_plan_id]
            )
          end
        else
          #calculation
        end
      end
    end
  end

  def edit
    @shopping_list_items = ShoppingListItem.mpfind(params([:id]))
  end

  def update
  end
end
