class Setting < ActiveRecord::Base
  attr_accessible :public_product_notification

  belongs_to :user
end
