class ChangeColumnNameInIngredients < ActiveRecord::Migration[6.0]
  def change
    rename_column :ingredients, :unit, :standard_unit
  end

end
