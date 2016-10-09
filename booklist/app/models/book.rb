class Book < ActiveRecord::Base
	has_many :reviews, dependent: :destroy

	has_attached_file :photo, styles: { medium: "90x160#"}
	validates_attachment_content_type :photo, content_type: /\A\/.*\z/
  
	validates :title, presence: true, length: { in: 2..100 }
	validates :description, presence: true , length: { maximum: 1000 }
	validates :isbn, presence: true, uniqueness: true, numericality: { only_integer: true }

	scope :search, ->(title) do
		where("books.title LIKE ?", "%#{title}%") unless title.blank?
	end

	scope :asc, -> do
		order(created_at: :asc)
	end

	def avg_rating(book)
		avg_rating, reviews = 0, book.reviews.count
		book.reviews.each {|review| avg_rating += review.rating }

		if reviews == 0
			reviews
		else
			(avg_rating/reviews).round(2)
		end
	end
end