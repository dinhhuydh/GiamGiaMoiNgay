class ProductsConsumer < ActiveRecord::Base
  attr_accessible :product_id, :consumer_id

  belongs_to :product
  belongs_to :consumer, class_name: 'User'
end
