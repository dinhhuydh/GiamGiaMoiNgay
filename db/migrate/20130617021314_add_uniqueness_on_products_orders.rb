class AddUniquenessOnProductsOrders < ActiveRecord::Migration
  def change
    add_index :products_orders, [:product_id, :user_id], unique: true
  end
end
