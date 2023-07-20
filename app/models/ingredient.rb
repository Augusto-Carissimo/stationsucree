class Ingredient < ApplicationRecord
  has_one :inventory, dependent: :destroy

  validates :name_ingredient, presence:, uniqueness: true
end
