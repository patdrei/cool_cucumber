class Preference < ApplicationRecord
  belongs_to :ingredient, optional: true
  belongs_to :tag, optional: true
  belongs_to :user
end
