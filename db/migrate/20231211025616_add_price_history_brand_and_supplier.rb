class AddPriceHistoryBrandAndSupplier < ActiveRecord::Migration[7.0]
  def change
    add_column :price_histories, :brand, :string
    add_column :price_histories, :supplier, :string
  end
end
