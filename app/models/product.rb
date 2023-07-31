class Product < ApplicationRecord
  has_many :stock_per_locations, dependent: :destroy

  validates :name_product, presence:, uniqueness: true
end
