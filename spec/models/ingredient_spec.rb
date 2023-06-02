require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  it { is_expected.to have_one(:inventory) }
end
