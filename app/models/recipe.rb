class Recipe < ApplicationRecord
  has_one :ingredient_recipe, dependent: :destroy

  validates :name_recipe, presence:, uniqueness: true
end
