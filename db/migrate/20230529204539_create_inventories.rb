class CreateInventories < ActiveRecord::Migration[7.0]
  def change
    create_table :inventories do |t|
      t.references :ingredient, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
