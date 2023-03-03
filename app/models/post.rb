# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :tagmaps, dependent: :destroy
  has_many :post_tags, through: :tagmaps

  has_one_attached :post_image

  # 投稿画像の設定
  def post_get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image_square.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  # タグ登録メソッド、新しいタグを判定し登録
  def save_tag(sent_post_tags)
    current_post_tags = self.post_tags.pluck(:name) unless self.post_tags.nil?
    old_tags = current_post_tags - sent_post_tags
    new_tags = sent_post_tags - current_post_tags

    old_tags.each do |old|
      self.post_tags.delete PostTag.find_by(name: old)
    end

    new_tags.each do |new|
      new_post_tag = PostTag.find_or_create_by(name: new)
      self.post_tags << new_post_tag
    end
  end

  # ransackの設定
  def self.ransackable_associations(auth_object = nil)
    %w[comments favorites post_image_attachment post_image_blob post_tags tagmaps user]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[created_at id post_text title name updated_at user_id is_deleted]
  end
end
