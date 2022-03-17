class Channel < ActiveRecord::Base
  belongs_to :admin, class_name: 'User'
  has_many :rooms, dependent: :destroy
  has_many :users, through: :rooms
  has_many :posts, dependent: :destroy
end
  
  