# frozen_string_literal: true

class ChangeColumnIngredients < ActiveRecord::Migration[7.0]
  def change
    change_column :ingredients, :last_price, :float, default: 0.0
  end
end
