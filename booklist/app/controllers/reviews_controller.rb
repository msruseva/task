class ReviewsController < ApplicationController
	before_action :set_book

	def index
		@reviews = @book.reviews.desc
		@reviews = @reviews.paginate(:page => params[:page], :per_page => 3)

		respond_to do |format|
			format.html {}											# show.html.erb
      		format.json { render json: @reviews }
	  	end
	end

	def new
		@review = Review.new
	end

	def create
		@review = Review.new(review_params)
		@review.book_id = params[:book_id]

		if @review.save
			redirect_to book_path(@book)
		else
			render :new, status: :unprocessable_entity
		end
	end

	def edit
		@review = Review.find(params[:id])
	end

	def update
		@review = Review.find(params[:id])

	    if @review.update(review_params)
	      redirect_to book_reviews_path(@book)
	    else
	      render :new, status: :unprocessable_entity #422
	    end
	end

	def destroy
		@review = Review.find(params[:id])

		if @review.destroy
	    	flash[:notice] = "Successfully deleted review."
	    else
	    	flash[:notice] = "Review was not deleted. Try again later."
	    end
	    redirect_to book_reviews_path(@book)
	end

	private

	def review_params
		params.require(:review).permit(:rating, :content)
	end

	def set_book
		@book = Book.find(params[:book_id])
	end
end