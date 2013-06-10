class CreateProductsConsumers < ActiveRecord::Migration
  def change
    create_table :products_consumers do |t|
      t.integer :product_id
      t.integer :consumer_id

      t.timestamps
    end
  end
end
