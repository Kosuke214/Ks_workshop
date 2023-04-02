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

  with_options length: { in: 1..255 } do
    validates :email
    validates :introduction
  end

  with_options length: { in: 1..20 } do
    validates :last_name
    validates :first_name
    validates :nickname
  end

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_profile.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default_profile_image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  # ゲストの登録情報設定
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.last_name = 'ゲスト'
      user.first_name = '太郎'
      user.nickname = 'ゲスト'
      user.password = SecureRandom.urlsafe_base64 # パスワードはランダムで設定
      user.diy_history = 0
      user.introduction = 'ゲストログイン中'
    end
  end

  # 投稿の非表示設定
  def hidden
    self.title = '表示が規制されております。'
    self.post_text = 'こちらの投稿は不適切な内容が含まれている可能性があるため、管理者により表示を規制されております。'
  end

  # パスワードなしでユーザ情報変更の許可
  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update(params, *options)
    clean_up_passwords
    result
  end
end
