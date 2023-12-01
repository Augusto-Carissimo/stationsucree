class DropMistakenTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :positions
  end
end
