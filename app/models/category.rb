class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  scope :asc_by_name, ->{order :name}
  scope :limit_category, ->{limit Settings.category.limit}
end
