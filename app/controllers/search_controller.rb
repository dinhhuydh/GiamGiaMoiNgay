class SearchController < ApplicationController
  def products
    @products = Product.search(params[:query])
  end
end
