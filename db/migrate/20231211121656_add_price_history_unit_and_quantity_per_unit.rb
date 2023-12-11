class AddPriceHistoryUnitAndQuantityPerUnit < ActiveRecord::Migration[7.0]
  def change
    add_column :price_histories, :unit, :string
    add_column :price_histories, :quantity_per_unit, :decimal, precision: 8, scale: 3
  end
end
