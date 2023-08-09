class Recipe < ApplicationRecord
  has_many :ingredient_recipes, dependent: :destroy
  belongs_to :product
end
