class Relationship < ApplicationRecord
  belongs_to :post
  belongs_to :category

  scope :cat_id, -> (cat_id) { where category_id: cat_id }
end
