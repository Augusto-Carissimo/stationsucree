# frozen_string_literal: true

FactoryBot.define do
  factory :ingredient_recipe do
    recipe
    ingredient
  end
end
