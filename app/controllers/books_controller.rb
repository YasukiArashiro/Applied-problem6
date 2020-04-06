class BooksController < ApplicationController

	before_action :ensure_current_user, only: [:edit, :update]

	def ensure_current_user
		if user_signed_in?
	    	book = Book.find(params[:id])
	    	if current_user.id !=  book.user_id
	      		redirect_to books_path
	    	end
	    end
  	end

	def index
		if user_signed_in?
			@book = Book.new
			@books = Book.all
		else
			redirect_to new_user_session_path
		end
	end

	def show
		if user_signed_in?
			@book = Book.find(params[:id])
			@user = User.find(@book.user_id)
			@book_comment = BookComment.new
			@book_comments = BookComment.where(book_id: @book.id)
		else
			redirect_to new_user_session_path
		end
	end

	def create
		book = Book.new(book_params)
		book.user_id = current_user.id
		if book.save
		   redirect_to book_path(book.id), notice: 'Book was successfully created.'
		else
			@user = User.find(current_user.id)
			@book = book
			@books = Book.all
			render action: :index
		end
	end

	def edit
		if user_signed_in?
			@book = Book.find(params[:id])
		else
			redirect_to new_user_session_path
		end
	end

	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
			redirect_to book_path(@book.id), notice: 'You have updated book successfully.'
		else
			render action: :edit
		end
	end

	def destroy
		book = Book.find(params[:id])
		book.destroy
		redirect_to books_path
	end


	private
    def book_params
        params.require(:book).permit(:title, :body)
    end


end
