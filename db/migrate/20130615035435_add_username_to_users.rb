class AddUsernameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string

    User.reset_column_information
    User.find_each do |user|
      user.username = user.email.split('@').first
      user.save
    end
  end
end
