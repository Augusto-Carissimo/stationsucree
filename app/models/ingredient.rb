class Ingredient < ApplicationRecord
  validates :name_ingredient, presence:, uniqueness: true
  validates :last_price, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity_ingredient, numericality: { greater_than_or_equal_to: 0 }
end
