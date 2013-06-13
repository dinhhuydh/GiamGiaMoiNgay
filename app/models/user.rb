class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :products_followers, dependent: :destroy, foreign_key: 'follower_id'
  has_many :followed_products, through: :products_followers
  has_many :products_consumers, dependent: :destroy, foreign_key: 'consumer_id'
  has_many :bought_products, through: :products_consumers, source: :product

  def follow(product)
    products_followers.create(product_id: product.id)
  end

  def follow?(product)
    followed_products.include?(product)
  end

  def buy(product)
    product.be_confirming!
    products_consumers.create(product_id: product.id)
  end

  def buy?(product)
    bought_products.include?(product)
  end
end
