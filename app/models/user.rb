# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum diy_history: { half_year: 0, one_year: 1, two_years: 2, three_years: 3, over_three_years: 4 }

  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :favorite, dependent: :destroy

  has_one_attached :profile_image

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.last_name = 'ゲスト'
      user.first_name = '太郎'
      user.nickname = 'ゲスト'
      user.password = SecureRandom.urlsafe_base64
      # パスワードはランダムで設定
      user.diy_history = 0
      user.introduction = 'ゲストログイン中'
    end
  end
end
