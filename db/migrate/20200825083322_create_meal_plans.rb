class CreateMealPlans < ActiveRecord::Migration[6.0]
  def change
    create_table :meal_plans do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
