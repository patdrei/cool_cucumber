class Tag < ApplicationRecord
  has_many :recipe_tags
  has_many :recipes, though: :recipe_tags
  has_many :preferences
end
