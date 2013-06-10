class AddUniquenessToProductsConsumers < ActiveRecord::Migration
  def change
    add_index :products_consumers, [:product_id, :consumer_id], unique: true
  end
end
