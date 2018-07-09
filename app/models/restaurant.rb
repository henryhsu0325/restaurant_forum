class Restaurant < ApplicationRecord
  mount_uploader :image, PhotoUploader
  validates_presence_of :name

  belongs_to :category
  
  # 當Restaurant 物件被刪除時，會順道刪除其下面的Comment
  has_many :comments, dependent: :destroy
end