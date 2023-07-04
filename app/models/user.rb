class User < ApplicationRecord
  has_secure_password

  has_many :messages, dependent: :destroy
  has_many :news, dependent: :destroy
  has_many :user_friends, dependent: :destroy
  has_many :friends, through: :user_friends
end
