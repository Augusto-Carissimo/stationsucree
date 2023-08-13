class Product < ApplicationRecord
  has_many :stock_per_locations, dependent: :destroy
  has_one :recipe, dependent: :destroy

  validates :name_product, presence:, uniqueness: true
  validates :quantity_product, numericality: { greater_than_or_equal_to: 0 }

end
