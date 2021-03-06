class User < ApplicationRecord
  include ApplicationHelper
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  #上傳圖片的gem
  #mount_uploader :avatar, AvatarUploader

  # 需要 app/views/devise 裡找到樣板，加上 name 屬性
  # 並參考 Devise 文件自訂表單後通過 Strong Parameters 的方法
  validates_presence_of :name
  # 加上驗證 name 不能重覆 (關鍵字提示: uniqueness)
  validates_uniqueness_of :name
  
  #處理tweet的關聯
  has_many :tweets, dependent: :destroy
  
  #處理reply的關聯
  has_many :replies, dependent: :restrict_with_error

  #處理like的關聯
  has_many :likes, dependent: :destroy
  has_many :like_tweets, through: :likes, source: :tweet

  #處理followship的關聯
  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships

  #處理followers的關聯
  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id"
  has_many :followers, through: :inverse_followships, source: :user

  #確認是管理者
  def admin?
    self.role == "admin"
  end

  #確認是否有追隨
  def following?(user)
    self.followings.include?(user)
  end

end
