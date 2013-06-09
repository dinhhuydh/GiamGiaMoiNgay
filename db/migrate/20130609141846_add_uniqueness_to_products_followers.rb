class AddUniquenessToProductsFollowers < ActiveRecord::Migration
  def change
    add_index :products_followers, [:product_id, :follower_id], unique: true
  end
end
