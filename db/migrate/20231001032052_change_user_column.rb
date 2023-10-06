# frozen_string_literal: true

class ChangeUserColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :username, :email
  end
end
