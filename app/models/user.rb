class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :user_image

  has_many :posts , dependent: :destroy
  has_many :favorites , dependent: :destroy

  has_many :relationships , class_name: "Relationship" , foreign_key: "follower_id" , dependent: :destroy
  has_many :reserve_of_relationships , class_name: "Relationship" , foreign_key: "followed_id" , dependent: :destroy
  has_many :followings , through: :relationships , source: :followed
  has_many :followers , through: :reserve_of_relationships , source: :follower

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.name = "ゲスト"
      user.password = SecureRandom.urlsafe_base64
    end
  end

end
