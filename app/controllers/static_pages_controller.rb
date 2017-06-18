class StaticPagesController < ApplicationController

	def index
		published_work = Work.where(status: 1)
		@newest_works = published_work.order(created_at: :desc).limit(12)
		@most_read_works = published_work.order(views: :desc).limit(12)
	end

	def search
		published_work = Work.where(status: 1)
		@works = published_work.search(params[:search]).order(created_at: :desc).limit(12)	
		@users = User.search(params[:search]).order(created_at: :desc).limit(12) 
		respond_to do |format|
			format.js
			format.html
		end		
	end

	def why
		
	end
end
