class AddExcerptToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :desc, :text
  end
end
