class AddBookCommentsCountToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :book_comments_count, :integer
  end
end
