class StaticPagesController < ApplicationController

	def index
	@users = User.all	
	@works = Work.all
		if params[:search] # that's what the user is searching for
			@works = Work.search(params[:search]).order(created_at: :desc)		
		end
	end
end
