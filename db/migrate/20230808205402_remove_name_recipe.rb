# frozen_string_literal: true

class RemoveNameRecipe < ActiveRecord::Migration[7.0]
  def change
    remove_column :recipes, :name_recipe
  end
end
