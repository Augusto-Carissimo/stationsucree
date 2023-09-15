# frozen_string_literal: true

class RefactorIngredient < ActiveRecord::Migration[7.0]
  def change
    remove_column :ingredients, :size
    remove_column :ingredients, :brand
    remove_column :ingredients, :description
    add_column :ingredients, :quantity_ingredients, :float, default: 0.0
  end
end
