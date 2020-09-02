class ShoppingListItemsController < ApplicationController
  def index
    @meal_plan = MealPlan.find(params[:meal_plan_id])
    @shopping_list_items = @meal_plan.shopping_list_items
  end

  def edit
    @shopping_list_item = ShoppingListItem.find(params([:id]))
  end

  def update
  end

  def change_purchased
    @shopping_list_item = ShoppingListItem.find(params[:id])
    if @shopping_list_item.purchased == true
      @shopping_list_item.purchased = false
    else
      @shopping_list_item.purchased = true
    end
    @shopping_list_item.save
  end
end
