class PriceHistory < ApplicationRecord
  belongs_to :ingredient

  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
