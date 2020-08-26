class RemoveNullContraintFromPreferences < ActiveRecord::Migration[6.0]
  def change
    change_column_null :preferences, :ingredient_id, true
    change_column_null :preferences, :tag_id, true
  end
end
