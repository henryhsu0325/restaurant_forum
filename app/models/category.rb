class Category < ApplicationRecord
  validates_presence_of :name

  # 若分類以下有餐廳，不允許刪除該分類（刪除顯示Error）
  has_many :restaurants, dependent: :restrict_with_error
end
