module ApplicationHelper

  def category
    @categories = Category.asc_by_name.limit_category
  end

  def rate_value value
    @product.comments.count_rate value
  end
end
