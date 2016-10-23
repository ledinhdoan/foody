class Admin::SuggestsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_suggest, only: [:show, :update, :edit, :destroy]

  def index
    @suggests = Suggest.newest.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def show
  end

  def edit
  end

  def update
    if @suggest.update_attributes suggest_params
      flash.now[:success] = "done"
      redirect_to admin_suggests_path
    else
      flash.now[:warning] = "fail"
      render :edit
    end
  end

  def destroy
    if @suggest.destroy
      flash[:success] = "done"
      redirect_to suggests_path
    else
      flash.now[:warning] = "fail"
      redirect_to root_path
    end
  end

  private
  def load_suggest
    @suggest = Suggest.find_by id: params[:id]
    unless @suggest
      flash.now[:warning] = "not_found"
      redirect_to root_path
    end
  end

  def suggest_params
    params.require(:suggest).permit :name, :body, :image, :price, :status
  end
end
