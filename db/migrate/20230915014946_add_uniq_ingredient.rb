class AddUniqIngredient < ActiveRecord::Migration[7.0]
  def change
    add_index :ingredients, :name_ingredient, unique: true
  end
end
