require 'texticle/searchable'

class Product < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  include AASM

  #TODO seach on name and description
  extend Searchable(:name)

  attr_accessible :name, :price, :sale_by_day,
                  :initial_price, :public_time, :slug,
                  :images, :images_attributes,
                  :aasm_state, :description

  validates_presence_of :name, :price, :sale_by_day,
                        :initial_price, :public_time

  has_many :images, :as => :owner, :dependent => :destroy
  accepts_nested_attributes_for :images

  has_many :products_followers, dependent: :destroy
  has_many :followers, through: :products_followers
  has_many :products_consumers, dependent: :destroy
  has_many :consumers, through: :products_consumers
  has_many :products_orders, dependent: :destroy
  has_many :orders, through: :products_orders, source: :user

  after_create :set_price_down_schedule

  scope :newest, order('created_at asc')
  scope :much_price_down, order('created_at desc')

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
      transitions :from => :confirming, :to => :sold, :on_transition => Proc.new{|obj| obj.delay.already_sold_notification }
    end
  end

  def next_sale_off_time
    next_time = public_time + eval("#{(Time.now.to_date - public_time.to_date).to_i}.day")
    if next_time < Time.now
      next_time += 1.day
    end
    next_time
  end

  private

  def set_price_down_schedule
    self.delay(run_at: self.next_sale_off_time).price_down_schedule
  end

  def price_down_schedule
    if !sold? && (price - sale_by_day > 0)
      self.price = self.price - sale_by_day
      self.save
      self.delay(run_at: self.next_sale_off_time).price_down_schedule
      ProductMailer.price_descreased(self).deliver
    end
  end

  def already_sold_notification
    followers.each do |follower|
      ProductMailer.already_sold(self, follower).deliver
    end
  end
end
