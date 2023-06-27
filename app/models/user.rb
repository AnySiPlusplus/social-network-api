class User < ApplicationRecord
  has_secure_password

  has_many :messages, dependent: :destroy
  has_many :news, dependent: :destroy
end
