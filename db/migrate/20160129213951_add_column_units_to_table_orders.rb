class AddColumnUnitsToTableOrders < ActiveRecord::Migration
  def change
    add_column :orders, :units, :integer
  end
end
