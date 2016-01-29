class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :id_products
      t.integer :id_user

      t.timestamps null: false
    end
  end
end
