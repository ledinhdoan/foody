module ApplicationHelper

  def category
    @categories = Category.asc_by_name.limit_category
  end
end
