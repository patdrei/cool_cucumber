class CreateMeals < ActiveRecord::Migration[6.0]
  def change
    create_table :meals do |t|
      t.references :recipe, null: false, foreign_key: true
      t.references :meal_plan, null: false, foreign_key: true
      t.boolean :done

      t.timestamps
    end
  end
end
