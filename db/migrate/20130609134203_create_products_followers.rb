class CreateProductsFollowers < ActiveRecord::Migration
  def change
    create_table :products_followers do |t|
      t.integer :follower_id
      t.integer :product_id

      t.timestamps
    end
  end
end
