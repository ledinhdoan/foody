class StaticpagesController < ApplicationController

  def index
    @products_newest = Product.newest.limit_product
  end
end
