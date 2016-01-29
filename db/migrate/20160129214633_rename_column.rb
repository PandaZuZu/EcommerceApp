class RenameColumn < ActiveRecord::Migration
  def change
    rename_column :orders, :id_user, :user_id
    rename_column :orders, :id_products, :products_id
  end
end
