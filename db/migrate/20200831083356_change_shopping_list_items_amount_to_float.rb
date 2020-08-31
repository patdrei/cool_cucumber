class ChangeShoppingListItemsAmountToFloat < ActiveRecord::Migration[6.0]
  def change
    change_column :shopping_list_items, :amount, :float
  end
end
