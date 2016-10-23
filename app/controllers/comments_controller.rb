class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_product
  before_action :load_comment, except: :create

  def index
    @comments = Comment.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def show
  end

  def new
  end

  def create
    @comment = @product.comments.create comment_params
    if @comment.save
      respond_to do |format|
        format.html do
          flash[:success] = t "comment.create"
          redirect_to @product
        end
        format.js
      end
    end
  end

  def edit
  end

  def update
    if @comment.update_attributes comment_params
      flash[:success] = t "comment.updated"
      redirect_to @product
    else
      render :edit
    end
  end

  def destroy
    if @comment.destroy
      respond_to do |format|
        format.html do
          flash[:success] = t "comment.deleted"
          redirect_to @product
        end
        format.js
      end
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :rating).merge user_id: current_user.id
  end

  def load_product
    @product = Product.find_by id: params[:product_id]
    unless @product
      flash.now[:warning] = t "product.not_found"
      redirect_to root_path
    end
  end

  def load_comment
    @comment = Comment.find_by id: params[:id]
    unless @comment
      flash.now[:warning] = t "comment.not_found"
      redirect_to root_path
    end
  end
end
