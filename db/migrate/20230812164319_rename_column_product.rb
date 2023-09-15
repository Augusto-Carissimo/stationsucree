# frozen_string_literal: true

class RenameColumnProduct < ActiveRecord::Migration[7.0]
  def change
    rename_column :products, :recipe, :recipe_text
  end
end
