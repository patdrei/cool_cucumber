class ShoppingListChannel < ApplicationCable::Channel
  def subscribed
    # meal_plan = Mealplan.find(params[:id])
    # stream_for shopping_list
    # # stream_from "some_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
