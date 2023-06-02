require 'rails_helper'

RSpec.describe SupplierIngredient, type: :model do
  it { is_expected.to belong_to(:ingredient) }
  it { is_expected.to belong_to(:supplier) }
end
