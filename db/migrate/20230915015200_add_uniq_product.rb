class AddUniqProduct < ActiveRecord::Migration[7.0]
  def change
    add_index :products, :name_product, unique: true
  end
end
