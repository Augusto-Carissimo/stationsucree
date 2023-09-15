# frozen_string_literal: true

class StockPerLocation < ApplicationRecord
  belongs_to :location
  belongs_to :product

  validates :quantity_stock, numericality: { greater_than_or_equal_to: 0 }
end
