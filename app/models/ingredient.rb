class Ingredient < ApplicationRecord
  has_one :inventory

  validates :name_ingredient, presence:, uniqueness: true
end
