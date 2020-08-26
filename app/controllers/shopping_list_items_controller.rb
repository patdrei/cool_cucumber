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
