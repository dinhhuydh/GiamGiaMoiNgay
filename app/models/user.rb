class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :products_followers, dependent: :destroy, foreign_key: 'follower_id'
  has_many :products, through: :products_followers

  def follow(product)
    products_followers.create(product_id: product.id)
  end
end
