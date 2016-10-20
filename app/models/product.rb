class Product < ApplicationRecord
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_many :orders, through: :order_details

  scope :asc_by_name, ->{order :name}
  scope :desc_by_name, ->{order name: :desc}
  scope :asc_by_price, ->{order :price}
  scope :desc_by_price, ->{order price: :desc}
  scope :newest, ->{order created_at: :desc}
  scope :limit_product, ->{limit Settings.product.limit}
end
