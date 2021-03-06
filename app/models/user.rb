class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  mount_uploader :avatar, AvatarUploader

  
  # 若 user 已留下評論，不允許刪除此帳號（刪除時顯示 Error ）
  # 「使用者評論很多餐廳」的多對多關聯
  has_many :comments, dependent: :restrict_with_error 
  has_many :restaurants, through: :comments

  # 設定其依賴的 User 物件被刪除時，相關的 Favorite 物件會一併刪除
  #「使用者收藏很多餐廳」的多對多關聯
  # 關聯名稱會和「使用者評論很多餐廳」重複，將關聯名稱自訂為：favorited_restaurants
  # 自訂名稱後， Rails 無法自動推論來源名稱，需另加 source 告知 model name
  has_many :favorites, dependent: :destroy
  has_many :favorited_restaurants, through: :favorites, source: :restaurant

  has_many :likes, dependent: :destroy
  has_many :liked_restaurants, through: :likes, source: :restaurant
 
  # 設定 User和 followships 的多對多關聯 
  # 不需要另加 source，Rails 可從 Followship Model 設定來判斷 followings 指向 User Model
  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships


  # 「使用者的追蹤者」設定
  # class_name, foreign_key 的自訂，指向 Followship
  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id"
  has_many :followers, through: :inverse_followships, source: :user

    # admin? 讓我們用來判斷單個user是否有 admin 角色，列如：current_user.admin?
  def admin?
    self.role == "admin"
  end

  def following?(user)
    self.followings.include?(user)
  end
end
