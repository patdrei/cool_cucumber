class CreateIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :ingredients do |t|
      t.string :unit
      t.string :name
      t.string :group

      t.timestamps
    end
  end
end
