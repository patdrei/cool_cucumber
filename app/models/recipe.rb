class Recipe < ApplicationRecord
  has_many :recipe_ingredients
  has_many :ingredients, though: :recipe_ingredients
  has_many :recipe_tags
  has_many :tags, though: :recipe_tags
  has_many :meals
  has_many :meal_plans, though: :meals
end
