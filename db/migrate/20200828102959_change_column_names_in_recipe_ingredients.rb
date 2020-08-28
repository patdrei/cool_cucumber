class ChangeColumnNamesInRecipeIngredients < ActiveRecord::Migration[6.0]
  def change
    rename_column :recipe_ingredients, :amount, :standard_amount
    rename_column :recipe_ingredients, :converted_amount, :display_amount
    rename_column :recipe_ingredients, :converted_unit, :display_unit

  end
end
