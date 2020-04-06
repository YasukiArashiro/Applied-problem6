class FavoritesController < ApplicationController

	def create
		favorite = Favorite.create(user_id: current_user.id, book_id: params[:book_id])
		@books = Book.all
		redirect_back(fallback_location: root_path)
	end

	def destroy
		favorite = Favorite.find_by(user_id: current_user.id, book_id: params[:book_id])
		favorite.destroy
		@books = Book.all
		redirect_back(fallback_location: root_path)
	end

end
