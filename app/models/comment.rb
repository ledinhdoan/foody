class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product

  delegate :name, to: :user
  scope :count_rate, ->value{where(rating: value).count(:rating)}
  scope :newest, ->{order created_at: :desc}
end
