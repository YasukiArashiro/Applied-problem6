class SearchesController < ApplicationController

	def search
		if params[:range] == 'user'
			match = params[:match]
			search = params[:search]
			if match == 'perfect'
				@users = User.where(name: search)
			elsif match == 'start'
				@users = User.all.search_start(search)
			elsif match == 'back'
				@users = User.all.search_back(search)
			elsif match == 'part'
				@users = User.all.search_part(search)
			end
			render :search_user
		else
			match = params[:match]
			search = params[:search]
			if match == 'perfect'
				@books = Book.where(title: search)
			elsif match == 'start'
				@books = Book.all.search_start(search)
			elsif match == 'back'
				@books = Book.all.search_back(search)
			elsif match == 'part'
				@books = Book.all.search_part(search)
			end
			render :search_book
		end
	end


	def search_user

	end

	def search_book

	end

end