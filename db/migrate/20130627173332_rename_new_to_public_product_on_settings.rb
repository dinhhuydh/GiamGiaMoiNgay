class RenameNewToPublicProductOnSettings < ActiveRecord::Migration
  def change
    rename_column :settings, :new_product_notification, :public_product_notification
  end
end
