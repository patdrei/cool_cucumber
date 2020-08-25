class CreateShoppingListItems < ActiveRecord::Migration[6.0]
  def change
    create_table :shopping_list_items do |t|
      t.references :ingredient, null: false, foreign_key: true
      t.references :meal_plan, null: false, foreign_key: true
      t.integer :amount
      t.boolean :purchased

      t.timestamps
    end
  end
end
