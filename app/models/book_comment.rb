class BookComment < ApplicationRecord
	belongs_to :user
	belongs_to :book, counter_cache: :book_comments_count

	validates :comment, presence: true
end
