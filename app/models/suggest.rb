class Suggest < ApplicationRecord
  belongs_to :user

  mount_uploader :image, PictureUploader

  validates :name, presence: :true
  validates :body, presence: :true
  validates :price, numericality: { greater_than_or_equal_to: 0, allow_nil: true }

  scope :newest, ->{order created_at: :desc}
end
