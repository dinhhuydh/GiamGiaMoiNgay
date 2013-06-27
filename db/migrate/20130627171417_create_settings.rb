class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.integer :user_id, unique: true
      t.boolean :new_product_notification, default: false

      t.timestamps
    end
  end
end
