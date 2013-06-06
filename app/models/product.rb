class Product < ActiveRecord::Base
  attr_accessible :bought, :name, :price, :sale_by_day, :public_date,
                  :initial_price

  validates_presence_of :name, :price, :sale_by_day, :public_date,
                        :initial_price
end
