class CreateSettingsForUsers < ActiveRecord::Migration
  def up
    User.find_each do |user|
      user.create_setting
    end
  end
end
