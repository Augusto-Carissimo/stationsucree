# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name_product { Faker::Food.dish }
  end
end
