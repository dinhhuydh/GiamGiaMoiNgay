class ProductsController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:index, :show, :price]
  before_filter :authenticate_admin_user!, only: [:new, :create, :edit, :update]

  expose(:product)
  expose(:products)

  def index
  end

  def show
  end

  def new
    3.times { product.images.build }
  end

  def create
    if product.save
      redirect_to product_path(product)
    else
      flash[:error] = 'Something wrong'
      render :new
    end
  end

  def edit
    product.images.build
  end

  def update
    if product.save
      redirect_to product_path(product)
    else
      flash[:error] = 'Something wrong'
      render :new
    end
  end

  def follow
    current_user.follow(product)
    render json: {followersCount: product.followers.count}
  end

  def buy
    current_user.order(product)
    render json: {ordersCount: product.orders.count}
  end

  def price
    render  json: { price: product.price,
                    nextSaleOffTime: product.next_sale_off_time }
  end
end
