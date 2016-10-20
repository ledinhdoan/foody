class CategoriesController < ApplicationController

  def index
    @categories = Category.asc_by_name
  end
end
