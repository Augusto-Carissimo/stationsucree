class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.string :name_location
      t.string :address
      t.integer :phone
      t.string :email

      t.timestamps
    end
  end
end
