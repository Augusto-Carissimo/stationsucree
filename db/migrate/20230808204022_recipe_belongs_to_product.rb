# frozen_string_literal: true

class RecipeBelongsToProduct < ActiveRecord::Migration[7.0]
  def change
    add_reference :recipes, :product, foreign_key: true, null: false
  end
end
