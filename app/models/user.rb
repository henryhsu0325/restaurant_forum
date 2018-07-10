class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  mount_uploader :avatar, AvatarUploader

  
  # 若user已留下評論，不允許刪除此帳號（刪除時顯示Error）
  # 「使用者評論很多餐廳」的多對多關聯
  has_many :comments, dependent: :restrict_with_error 
  has_many :restaurants, through: :comments

  # 設定其依賴的User物件被刪除時，相關的Favorite物件會一併刪除
  # 「使用者收藏很多餐廳」的多對多關聯，用favorited_restaurants以利讓系統分辨要索取的資訊
  has_many :favorites, dependent: :destroy
  has_many :favorited_restaurants, through: :favorites, source: :restaurant

    # admin? 讓我們用來判斷單個user是否有 admin 角色，列如：current_user.admin?
  def admin?
    self.role == "admin"
  end
end
