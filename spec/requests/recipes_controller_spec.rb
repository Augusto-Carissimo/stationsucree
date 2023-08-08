# frozen_string_literal: true
require 'rails_helper'

RSpec.describe RecipesController, type: :request do
  context do
    let!(:recipe) { Recipe.create(name_recipe: 'Cake recipe') }

  end
end