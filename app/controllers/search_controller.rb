class SearchController < ApplicationController

	def result_partial
		if params[:search] # that's what the user is searching for
			@works = Work.search(params[:search]).order(created_at: :desc).limit(12)	
		end
		render "static_pages/index"
	end
end
