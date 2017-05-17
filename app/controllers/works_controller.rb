class WorksController < ApplicationController
	layout "reader", only: :show 
	before_action :find_work, only: [:show]
	def index
		@works = Work.all
		if params[:search] #This is what the user is searching for
			@works = Work.search(params[:search]).order(created_at: :desc)
		end
		
	end

	def show 
		@user = User.find(@work.user_id)
	end


	private

	def find_work
		@work = Work.friendly.find(params[:id])
	end
end
