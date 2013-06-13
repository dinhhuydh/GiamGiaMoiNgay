class RemoveBoughtToProducts < ActiveRecord::Migration
  def up
    remove_column :products, :bought
  end

  def down
    add_column :products, :bought, :boolean
  end
end
