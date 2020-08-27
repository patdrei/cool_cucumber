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
      @recipes.recipe_ingredients.each do |recipe_ingredient|
        ShoppingListItem.create(
          ingredient_id: recipe_ingredient.ingredient_id,
          amount: recipe_ingredient.amount,
          purchased: false,
          meal_plan_id: params[:meal_plan_id]
        )
      end
    end
  end

  def edit
    @shopping_list_items = ShoppingListItem.mpfind(params([:id]))
  end

  def update
  end
end

# spi4 = ShoppingListItem.new(ingredient_id: 90, meal_plan_id:1, purchased: false)
# spi5 = ShoppingListItem.new(ingredient_id: 60, meal_plan_id:1, purchased: false)
# spi6 = ShoppingListItem.new(ingredient_id: 50, meal_plan_id:1, purchased: true)
# spi7 = ShoppingListItem.new(ingredient_id: 40, meal_plan_id:1, purchased: false)
# spi8 = ShoppingListItem.new(ingredient_id: 170, meal_plan_id:1, purchased: true)
# spi9 = ShoppingListItem.new(ingredient_id: 270, meal_plan_id:1, purchased: false)
# MealPlan.find(1).shopping_list_items.find(2).ingredient.recipe_ingredients

