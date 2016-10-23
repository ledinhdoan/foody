class ProductsController < ApplicationController
  before_action :load_product, only: :show

  def index
    if params[:type].nil?
      @products = Product.all.paginate page: params[:page],
        per_page: Settings.per_page
    else
      @products = Product.send(params[:type]).paginate page: params[:page],
        per_page: Settings.per_page
    end
  end

  def show
    @comments = @product.comments.paginate page: params[:page],
      per_page: Settings.per_page
    get_comment = @product.comments
    @avg_rating = get_comment.average(:rating)
      .present? ? get_comment.average(:rating) : 0
  end

  private
  def load_product
    @product = Product.find_by id: params[:id]
    unless @product
      flash.now[:warning] = t "product.not_found"
      redirect_to root_path
    end
  end
end
