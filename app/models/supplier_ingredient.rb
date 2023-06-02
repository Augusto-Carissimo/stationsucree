class SupplierIngredient < ApplicationRecord
  belongs_to :ingredient
  belongs_to :supplier
end
