class Post < ApplicationRecord
  has_one_attached :post_image

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :tagmaps, dependent: :destroy
  has_many :post_tags, through: :tagmaps

  validates :title, length: { in: 1..40 }
  validates :post_text, length: { in: 1..400 }

  # 投稿画像の設定
  def get_post_image(width, height)
    unless post_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      post_image.attach(io: File.open(file_path), filename: 'default_image.jpg', content_type: 'image/jpeg')
    end
    # image
    post_image.variant(resize_to_limit: [width, height]).processed
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

  # いいね済みかの判定メソッド
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  # 表示規制された投稿の表示切り替え
  def hidden
    # self.get_image = image_tag asset_path("error_rogo.svg")
    self.title = '表示が規制されております。'
    self.post_text = 'こちらの投稿は不適切な内容が含まれている可能性があるため、管理者により表示を規制されております。'
  end

  # ransackの設定
  def self.ransackable_associations(auth_object = nil)
    %w[comments favorites post_image_attachment post_image_blob post_tags tagmaps user]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[created_at id post_text title name updated_at user_id is_deleted]
  end
end
