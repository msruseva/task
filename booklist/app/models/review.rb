class Review < ActiveRecord::Base
	belongs_to :books

	validates :rating, presence: true, numericality: { minimum: 0.0 }
	validates :rating, presence: true, numericality: { maximum: 5.0 }
	validates :content, presence: true , length: { in: 20..250 }

	scope :desc, -> do
		order(created_at: :desc)
	end
end