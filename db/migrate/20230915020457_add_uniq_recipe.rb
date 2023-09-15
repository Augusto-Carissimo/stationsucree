class AddUniqRecipe < ActiveRecord::Migration[7.0]
  def change
    remove_index :recipes, :product_id
    add_index :recipes, :product_id, unique: true
  end
end
