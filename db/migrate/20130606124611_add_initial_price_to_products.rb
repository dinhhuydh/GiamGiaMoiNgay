class AddInitialPriceToProducts < ActiveRecord::Migration
  def change
    add_column :products, :initial_price, :float
  end
end
