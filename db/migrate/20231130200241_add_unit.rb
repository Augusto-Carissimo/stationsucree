class AddUnit < ActiveRecord::Migration[7.0]
  def change
    add_column :ingredients, :unit, :string
    add_column :ingredients, :quantity_per_unit, :decimal, precision: 8, scale: 3
  end
end
