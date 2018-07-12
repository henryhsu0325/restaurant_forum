class Followship < ApplicationRecord
  # 確保特定的 user_id 只會有一個 following_id
validates :following_id, uniqueness: { scope: :user_id }

# 由於 :following 指向 User Model, Rails無法自動推論
# 使用 :class_name 告知對應的 Model 名稱  
  belongs_to :user
  belongs_to :following, class_name: "User"
end
