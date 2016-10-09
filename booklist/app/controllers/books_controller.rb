class BooksController < ApplicationController

	def index
		@books = Book.search(params[:search]).asc
		@books = @books.paginate(:page => params[:page], :per_page => 10)
		
		respond_to do |format|
			format.html {}											# show.html.erb
			format.json { render json: @books }
		end
	end

	def new
		@book = Book.new
	end

	def create
		@book = Book.new(book_params)

		if @book.save
			redirect_to root_path
		else
			render :new, status: :unprocessable_entity #422
		end
	end

	def show
		@book = Book.find(params[:id])
		@reviews = @book.reviews.last(3)
	end

	def edit
		@book = Book.find(params[:id])
	end

	def update
		@book = Book.find(params[:id])

		if @book.update(book_params)
			redirect_to books_path
		else
			render :edit, status: :unprocessable_entity #422
		end
	end

	def destroy
		@book = Book.find(params[:id])

	    if @book.destroy
	    	flash[:notice] = "Successfully deleted book."
	    else
	    	flash[:notice] = "Book was not deleted. Try again later."
	    end
	    redirect_to books_path
	  end

	private

	def book_params
		params.require(:book).permit(:title, :description, :isbn, :photo)
	end

end