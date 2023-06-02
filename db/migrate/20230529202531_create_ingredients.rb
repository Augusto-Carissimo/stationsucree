class CreateIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredients do |t|
      t.string :name_ingredient
      t.string :attr_1
      t.string :attr_2
      t.string :attr_3
      t.datetime :exparation_date
      t.integer :last_price

      t.timestamps
    end
  end
end
