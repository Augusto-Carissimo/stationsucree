class Product < ApplicationRecord
  has_many :stock_per_locations

  validates :name_product, presence:, uniqueness: true
end
