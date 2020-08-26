class ShoppingListItemsController < ApplicationController
  def index
    @meal_plan = MealPlan.find(params[:meal_plan_id])
    @shopping_list_items = @meal_plan.shopping_list_items
  end

  def edit
    @shopping_list_items = ShoppingListItem.find(params([:id]))
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
