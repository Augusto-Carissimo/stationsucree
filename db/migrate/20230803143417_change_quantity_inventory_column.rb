class ChangeQuantityInventoryColumn < ActiveRecord::Migration[7.0]
  def change
    change_column :inventories, :quantity_inventory, :float
  end
end
