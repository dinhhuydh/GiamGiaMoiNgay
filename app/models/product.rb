class Product < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  attr_accessible :bought, :name, :price, :sale_by_day, :public_date,
                  :initial_price, :public_time, :slug,
                  :images, :images_attributes

  validates_presence_of :name, :price, :sale_by_day, :public_date,
                        :initial_price, :public_time

  has_many :images, :as => :owner, :dependent => :destroy
  accepts_nested_attributes_for :images

  def next_sale_off_time
    next_time = public_time + eval("#{(Time.now.to_date - public_time.to_date).to_i}.day")
    if next_time < Time.now
      next_time += 1.day
    end
    next_time
  end
end
