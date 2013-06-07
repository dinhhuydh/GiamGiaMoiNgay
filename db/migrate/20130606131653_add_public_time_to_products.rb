class AddPublicTimeToProducts < ActiveRecord::Migration
  def change
    add_column :products, :public_time, :datetime
  end
end
