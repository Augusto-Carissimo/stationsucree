# frozen_string_literal: true

class RemoveColumnIngredient < ActiveRecord::Migration[7.0]
  def change
    remove_column :ingredients, :attr_1
    remove_column :ingredients, :attr_2
    remove_column :ingredients, :attr_3
    remove_column :ingredients, :exparation_date
  end
end
