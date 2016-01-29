class AddColumnToProduct < ActiveRecord::Migration
  def change
    add_column :products, :units, :integer
  end
end
