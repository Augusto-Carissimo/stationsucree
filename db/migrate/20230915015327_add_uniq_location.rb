# frozen_string_literal: true

class AddUniqLocation < ActiveRecord::Migration[7.0]
  def change
    add_index :locations, :name_location, unique: true
  end
end
