class Product < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  include AASM

  attr_accessible :name, :price, :sale_by_day,
                  :initial_price, :public_time, :slug,
                  :images, :images_attributes

  validates_presence_of :name, :price, :sale_by_day,
                        :initial_price, :public_time

  has_many :images, :as => :owner, :dependent => :destroy
  accepts_nested_attributes_for :images

  has_many :products_followers, dependent: :destroy
  has_many :followers, through: :products_followers
  has_many :products_consumers, dependent: :destroy
  has_many :consumers, through: :products_consumers

  after_create :set_price_down_schedule

  aasm do
    state :private, initial: true
    state :public
    state :confirming
    state :sold

    event :be_public do
      transitions :from => :private, :to => :public
    end

    event :be_confirming do
      transitions :from => :public, :to => :confirming
    end

    event :be_sold do
      transitions :from => :confirming, :to => :sold
    end
  end

  def next_sale_off_time
    next_time = public_time + eval("#{(Time.now.to_date - public_time.to_date).to_i}.day")
    if next_time < Time.now
      next_time += 1.day
    end
    next_time
  end

  def set_price_down_schedule
    self.delay(run_at: self.next_sale_off_time).price_down_schedule
  end

  def price_down_schedule
    if price - sale_by_day > 0
      self.price = self.price - sale_by_day
      self.save
      self.delay(run_at: self.next_sale_off_time).price_down_schedule
    end
  end
end
