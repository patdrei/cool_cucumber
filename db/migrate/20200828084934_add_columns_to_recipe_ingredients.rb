class AddColumnsToRecipeIngredients < ActiveRecord::Migration[6.0]
  def change
    add_column :recipe_ingredients, :converted_amount, :float
    add_column :recipe_ingredients, :converted_unit, :string
  end
end
