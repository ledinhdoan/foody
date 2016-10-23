class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable,
    :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook]
  has_many :orders, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :suggests, dependent: :destroy

  scope :asc_by_email, ->{order :email}

  def is_user? user
    self == user
  end

  class << self
    def from_omniauth access_token
      data = access_token.info
      user = User.find_by email: data["email"]
      unless user
        password = Devise.friendly_token[0,20]
        user = User.create name: data["name"], email: data["email"],
          password: password, password_confirmation: password
      end
      user
    end
  end
end
