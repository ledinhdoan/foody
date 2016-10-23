class Admin::CategoriesController < ApplicationController
  layout "admin_application"
  before_action :find_category, except: [:create, :new, :index]
  before_action :is_admin

  def index
    @categories = Category.asc_by_name.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def show
    @products = @category.products.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      redirect_to admin_categories_path
    else
      @errors_count = @category.errors.size
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      redirect_to admin_category_path
    else
      @errors_count = @category.errors.size
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "category.deleted"
      redirect_to admin_categories_path
    else
      flash[:warning] = t "category.destroy_fail"
      redirect_to root_path
    end
  end

  private
  def category_params
    params.require(:category).permit :name, :created_at, :updated_at
  end

  def find_category
    @category = Category.find_by id: params[:id]
    unless @category
      flash[:warning] = t "category.not_found"
      redirect_to root_path
    end
  end
end
