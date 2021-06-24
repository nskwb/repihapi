class Post < ApplicationRecord
  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :notifications, dependent: :destroy

  default_scope -> { order(created_at: :desc) }

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :content, presence: true, length: { maximum: 200 }
  validates :user_id, presence: true
  validates :image, file_size: { less_than: 5.megabytes },
                    file_content_type: { allow: ['image/jpg', 'image/jpeg', 'image/png'] }
  validates :protein, presence: true
  validates :fat, presence: true
  validates :carbo, presence: true
  validates :calorie, presence: true

  mount_uploader :image, ImageUploader

  def favorited_by?(user)
    favorites.where('user_id = ?', user.id).exists?
  end

  def save_tags(posted_tags)
    # 更新しようとしているポストが現在持っているタグを取得
    current_tags = tags.pluck(:name) unless tags.nil?
    # 更新ポストにはないタグを取得
    old_tags = current_tags - posted_tags
    # 更新ポストで新たに追加されたタグを取得
    new_tags = posted_tags - current_tags

    # 更新ポストにはないタグ群をポストが所有するタグ群から削除
    old_tags.each do |old_tag_name|
      tags.delete Tag.find_by(name: old_tag_name)
    end

    new_tags.each do |new_tag_name|
      # 新たに追加されたタグの名前がTagテーブルにあれば取得、なければ作成
      post_tag = Tag.find_or_create_by(name: new_tag_name)
      # 自身のタグ群に追加
      tags << post_tag
    end
  end
end
