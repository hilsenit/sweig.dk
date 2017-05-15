class WorksController < ApplicationController
	layout :false, only: :show 

	def index
		@works = Work.all
		if params[:search] #This is what the user is searching for
			@works = Work.search(params[:search]).order(created_at: :desc)
		end
		
	end

	def show 
		@work = Work.find(params[:id])
		@user = User.find(@work.user_id)
	end
end
