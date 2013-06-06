class Product < ActiveRecord::Base
  attr_accessible :bought, :name, :price, :sale_by_day
end
