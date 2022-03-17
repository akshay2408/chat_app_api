class User < ActiveRecord::Base
  has_many :rooms, dependent: :destroy
  has_many :channels, through: :rooms, dependent: :destroy
  has_many :posts
end