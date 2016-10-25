class CartsController < ApplicationController
  before_action :authenticate_user!

  def index
    @order = Order.new
  end

  def update
    @cart.add_item params[:id]
    session[:cart] = @cart.sort
    respond_to do |format|
      format.js {render :update}
    end
  end

  def edit
    item = @cart.find_item params[:id]
    if item.quantity > 1
      item.decrement
      session[:cart] = @cart.sort
    end
    respond_to do |format|
      format.js {render :update}
    end
  end

  def destroy
    cart = session[:cart]
    item = cart["items"].find{|item| item["product_id"] == params[:id]}
    if item
      cart["items"].delete item
      create_cart
    end
    respond_to do |format|
      format.js {render :update}
    end
  end
end
