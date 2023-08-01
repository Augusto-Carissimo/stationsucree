class Inventory < ApplicationRecord
  belongs_to :ingredient

  validates :quantity_inventory, numericality: { greater_than_or_equal_to: 0 }
end
