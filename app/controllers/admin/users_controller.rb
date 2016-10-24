class Admin::UsersController < ApplicationController
  layout "admin_application"
  before_action :load_user, only: [:show, :destroy]
  before_action :verify_admin

  def index
    @users = User.asc_by_email.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def show
  end

  def destroy
    if @user.destroy
      flash[:success] = t "users.deleted"
      redirect_to admin_users_path
    else
      flash[:warning] = t "users.destroy_fail"
      redirect_to root_path
    end
  end
end
