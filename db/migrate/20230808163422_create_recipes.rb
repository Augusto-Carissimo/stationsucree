# frozen_string_literal: true

class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :name_recipe

      t.timestamps
    end
  end
end
