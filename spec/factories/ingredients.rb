# frozen_string_literal: true

FactoryBot.define do
  factory :ingredient do
    name_ingredient { Faker::Food.allergen }
  end
end
