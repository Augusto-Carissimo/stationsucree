class AddColumnProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :is_subproduct, :boolean, default: false
  end
end
