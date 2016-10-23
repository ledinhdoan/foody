class StaticpagesController < ApplicationController
  before_action :verify_admin

  def index
    @products_newest = Product.newest.limit_product
  end
end
