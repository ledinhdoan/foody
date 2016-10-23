class SuggestsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_suggest, except: [:new, :create]

  def index
    @suggests = current_user.suggests
  end

  def show
  end

  def new
    @suggest = Suggest.new
  end

  def create
    @suggest = Suggest.new suggest_params
    if @suggest.save
      flash[:success] = "done"
      redirect_to @suggest
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @suggest.update_attribute suggest_params
      flash.now[:success] = "done"
      redirect_to @suggest
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
    params.require(:suggest).permit :name, :body, :image, :price, :status, :user_id
  end
end
