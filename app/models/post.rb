class Post < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  mount_uploader :thumbnail, ThumbnailUploader
  validates :title, presence: true
  validates :desc, length: { maximum: 250 }

  belongs_to :user

  has_many :relationships, dependent: :destroy
  has_many :categories, through: :relationships

  scope :cat_id, -> (cat_id) { joins(:relationships).where("category_id = ?","#{cat_id}") }
  scope :user_id, -> (user_id) { where user_id: user_id }
end