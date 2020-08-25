class Ingredient < ApplicationRecord
  has_many :preferences
  has_many :recipe_ingredients
  has_many :shopping_list_items
  has_many :recipes, through: :recipe_ingredients
end
