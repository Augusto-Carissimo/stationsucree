class Location < ApplicationRecord
  has_many :stock_per_locations, dependent: :destroy

  validates :name_location, presence:, uniqueness: true

end
