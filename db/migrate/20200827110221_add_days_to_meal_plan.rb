class AddDaysToMealPlan < ActiveRecord::Migration[6.0]
  def change
    add_column :meal_plans, :days, :integer
  end
end
