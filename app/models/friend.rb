class Friend < ApplicationRecord
  belongs_to :user

  has_many :user_friends, dependent: :destroy
  has_many :users, through: :user_friends
end
