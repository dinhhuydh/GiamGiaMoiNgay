class SearchController < ApplicationController
  skip_before_filter :authenticate_user!

  def products
    @products = Product.search(params[:query])
  end
end
