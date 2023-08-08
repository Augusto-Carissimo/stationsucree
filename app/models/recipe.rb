class Recipe < ApplicationRecord
  has_one :ingredient_recipe, dependent: :destroy
  belongs_to :product
end
