class CreateStockPerLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :stock_per_locations do |t|
      t.references :location, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity_product

      t.timestamps
    end
  end
end
