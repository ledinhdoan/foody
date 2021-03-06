class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :create_cart

  protected
  def verify_admin
    redirect_to root_path unless current_user.is_admin?
  end

  def load_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:warning] = t "users.not_found"
      redirect_to root_path
    end
  end

  private
  def create_cart
    @cart = Cart.build_cart session
  end
end
