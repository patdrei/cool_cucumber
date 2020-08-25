class MealPlan < ApplicationRecord
  belongs_to :user_id
  has_many :shopping_list_items
  has_many :meals
  has_many :recipes, through: :meals
end
