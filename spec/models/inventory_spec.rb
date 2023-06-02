require 'rails_helper'

RSpec.describe Inventory, type: :model do
  it { is_expected.to belong_to(:ingredient) }
end
