# frozen_string_literal: true

class AddColumnIngredient < ActiveRecord::Migration[7.0]
  def change
    add_column :ingredients, :size, :float, default: 0.0
    add_column :ingredients, :brand, :string
    add_column :ingredients, :description, :string
  end
end
