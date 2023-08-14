class Ingredient < ApplicationRecord
  has_one :inventory, dependent: :destroy

  validates :name_ingredient, presence:, uniqueness: true
  validates :last_price, numericality: { greater_than_or_equal_to: 0 }
end
