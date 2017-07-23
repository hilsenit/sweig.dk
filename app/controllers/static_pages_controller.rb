class StaticPagesController < ApplicationController

	def index
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

	def nyt; end
	
	def opret 
		if user_signed_in?
			flash[:notice] = "Du er logget ind"
			redirect_to user_path(current_user.id)
		end
	end
	
	def laes 
		published_work = Work.where(status: 1)
		@newest_works = published_work.order(created_at: :desc).limit(12)
		@most_read_works = published_work.order(views: :desc).limit(12)
	end

	def kontakt

		KontaktMailer.kontakt(params[:email], params[:besked], params[:emne]).deliver

		flash[:notice] = "Din besked '#{params[:emne]}' er blevet sendt"
		redirect_to root_path
	end
end
