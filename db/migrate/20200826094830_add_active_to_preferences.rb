class AddActiveToPreferences < ActiveRecord::Migration[6.0]
  def change
    add_column :preferences, :active, :boolean
  end
end
