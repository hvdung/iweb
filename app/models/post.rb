class Post < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  mount_uploader :thumbnail, ThumbnailUploader
  validates :title, presence: true
  validates :desc, length: { maximum: 250 }
end
