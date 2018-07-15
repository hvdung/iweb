class Category < ApplicationRecord
  validates :title, presence: true
  validates :desc, length: { maximum: 250 }
  default_scope -> { order(created_at: :desc) }

  has_ancestry
end
