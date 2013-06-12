class RemovePublicDateToProducts < ActiveRecord::Migration
  def up
    remove_column :products, :public_date
  end

  def down
    add_column :products, :public_date, :date
  end
end
