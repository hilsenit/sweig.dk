class StaticPagesController < ApplicationController

	def index
		@newest_work = Work.all.order(created_at: :desc).limit(12)
		@most_read_work = Work.all.order(views: :desc).limit(12)
	end

	def search

		@works = Work.search(params[:search]).order(created_at: :desc).limit(12)	
		@users = User.search(params[:search]).order(created_at: :desc).limit(12) 
		respond_to do |format|
			format.js
			format.html
		end		
	end

	def why
		
	end
end
