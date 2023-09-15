# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username { Faker::Internet.username(specifier: 'test_user') }
    password { Faker::Internet.password }
  end
end
