class ProductsController < ApplicationController
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
end
