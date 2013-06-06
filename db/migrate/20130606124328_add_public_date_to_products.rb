class AddPublicDateToProducts < ActiveRecord::Migration
  def change
    add_column :products, :public_date, :date
  end
end
