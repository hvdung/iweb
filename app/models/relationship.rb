class Relationship < ApplicationRecord
  belongs_to :post
  belongs_to :category
end
