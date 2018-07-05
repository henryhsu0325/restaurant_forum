class AddAttributesToUsers < ActiveRecord::Migration[5.1]
  def change
    add_colum :user, :name, :string
    add_colum :user, :intro, :text
    add_colum :user, :avatar, :string #存放大頭貼資訊，將掛載至 CarrierWave 的 Uploader
 end
end
