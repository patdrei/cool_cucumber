class AddDataTypeOfAmount < ActiveRecord::Migration[6.0]
  def change
    change_column :recipe_ingredients, :amount, :float
  end
end
