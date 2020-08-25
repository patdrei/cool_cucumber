class Preference < ApplicationRecord
  belongs_to :ingredient
  belongs_to :tag
  belongs_to :user
end
