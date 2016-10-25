class Order < ApplicationRecord
  attr_accessor :cart

  belongs_to :user
  has_many :order_details, dependent: :destroy
  has_many :products, through: :order_details

  after_save :build_order_details

  scope :newest, ->{order created_at: :desc}
  private
  def build_order_details
    cart.items.each do |item|
      order_details.create product_id: item.product_id, quantity: item.quantity
    end
  end
end
