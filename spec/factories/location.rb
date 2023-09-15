# frozen_string_literal: true

FactoryBot.define do
  factory :location do
    name_location { Faker::Address.street_address }
  end
end
