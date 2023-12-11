class AddIngredientCurrentBrandAndCurrentSupplier < ActiveRecord::Migration[7.0]
  def change
    add_column :ingredients, :current_brand, :string
    add_column :ingredients, :current_supplier, :string
  end
end
