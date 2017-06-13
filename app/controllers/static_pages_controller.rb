class StaticPagesController < ApplicationController

	def index
	@page_title = "This is it!"	
	@users_for_overview = User.sort_users	
	@works = Work.all
		if params[:search] # that's what the user is searching for
			@works = Work.search(params[:search]).order(created_at: :desc)		
		end
	end

	def why
		
	end
end
