class Inventory < ApplicationRecord
  belongs_to :ingredient

  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
end