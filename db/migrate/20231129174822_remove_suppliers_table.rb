class RemoveSuppliersTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :supplier_ingredients
    drop_table :suppliers
  end
end
