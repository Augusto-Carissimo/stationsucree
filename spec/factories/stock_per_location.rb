# frozen_string_literal: true

FactoryBot.define do
  factory :stock_per_location do
    product
    location
  end
end
