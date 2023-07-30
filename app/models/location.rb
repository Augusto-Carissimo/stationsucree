class Location < ApplicationRecord
  has_many :stock_per_locations

  validates :name_location, presence:, uniqueness: true

end
