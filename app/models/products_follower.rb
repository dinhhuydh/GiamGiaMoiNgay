class ProductsFollower < ActiveRecord::Base
  attr_accessible :product_id, :user_id

  belongs_to :product
  belongs_to :follower, class_name: 'User'
end
