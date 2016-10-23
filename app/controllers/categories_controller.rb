class CategoriesController < ApplicationController
  before_action :load_category, only: :show

  def index
    @categories = Category.asc_by_name

  end

  def show
    @products = @category.products.paginate page: params[:page],
      per_page: Settings.per_page
  end

    def load_category
    @category = Category.find_by id: params[:id]
    unless @category
      flash[:warning] = "not_found"
      redirect_to root_path
    end
  end
end
