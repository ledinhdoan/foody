class Admin::ProductsController < ApplicationController
  layout "admin_application"
  before_action :find_product, except: [:create, :new, :index]
  before_action :verify_admin

  def index
    @products = Product.asc_by_name.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def show
  end

  def new
    @product = Product.new
    @categories = Category.all
    @suggest_name = params[:g_name]
    @suggest_price = params[:g_price]
    @suggest_body = params[:g_body]
  end

  def create
    @product = Product.new product_params
    if @product.save
      redirect_to admin_products_path
    else
      @errors_count = @product.errors.size
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update_attributes product_params
      redirect_to admin_product_path
    else
      @errors_count = @product.errors.size
      render :edit
    end
  end

  def destroy
    if @product.destroy
      flash[:success] = t "product.deleted"
      redirect_to admin_products_path
    else
      flash[:warning] = t "product.destroy_fail"
      redirect_to root_path
    end
  end

  private
  def product_params
    params.require(:product).permit :name, :price, :discount, :description,
      :rate, :created_at, :updated_at, :status, :image, :category_id
  end

  def find_product
    @product = Product.find_by id: params[:id]
    unless @product
      flash[:warning] = t "product.not_found"
      redirect_to root_path
    end
  end
end
