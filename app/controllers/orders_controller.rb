class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_order, only: :show

  def index
    @orders = current_user.orders.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def create
    if @cart.present?
      @order = Order.new order_params
      if @order.save
        session.delete :cart
        flash[:success] = t "success.orders.successful"
        redirect_to order_path @order
      else
        flash[:danger] = t "danger.orders.address"
        redirect_to :back
      end
    else
      flash[:danger] = t "carts.not_product"
      redirect_to carts_path
    end
  end

  def show
  end

  private
  def order_params
    params.require(:order).permit(:message).merge! user: current_user,
      order_total: @cart.total_price, cart: @cart
  end

  def load_order
    @order = Order.find_by id: params[:id]
    unless @order
      flash[:danger] = t "danger.orders.not_found"
      redirect_to root_path
    end
  end
end
