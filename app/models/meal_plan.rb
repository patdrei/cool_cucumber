class MealPlan < ApplicationRecord
  belongs_to :user
  has_many :shopping_list_items
  has_many :meals, dependent: :destroy
  has_many :recipes, through: :meals

  validates :days, presence: true
end
