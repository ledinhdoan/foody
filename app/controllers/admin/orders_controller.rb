class Admin::OrdersController < ApplicationController
  layout "admin_application"
  before_action :authenticate_user!, :verify_admin
  before_action :load_order, only: [:update, :edit, :show]

  def index
    @orders = Order.newest.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def edit
  end

  def show
  end

  def update
    if @order.update_columns(status: :true)
      redirect_to admin_order_path @order
    else
      @errors_count = @order.errors.size
      render :edit
    end
  end

  private
  def order_params
    params.require(:order).permit(:message, :status).merge! user: current_user
  end

  def load_order
    @order = Order.find_by id: params[:id]
    unless @order
      flash[:danger] = t "danger.orders.not_found"
      redirect_to root_path
    end
  end
end
