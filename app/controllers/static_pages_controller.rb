class StaticPagesController < ApplicationController
	before_action :is_user_signed_in?, only: [:log_in, :oprettelse]
	def index
	end

	def search
		published_work = Work.where(status: 1)
		@works = published_work.search(params[:search]).order(created_at: :desc).limit(12)	
		@users = User.search(params[:search]).order(created_at: :desc).limit(12) 
		$search = params[:search]
		respond_to do |format|
			format.js
			format.html
		end		
	end

	def log_in;end

	def oprettelse; end

		
	def laes 

		published_work = Work.where(status: 1)
		@works = published_work.order(created_at: :desc).limit(12)
		@users = User.order(created_at: :desc).limit(12)

		respond_to do |format|
			format.js
			format.html
		end
	end

	def kontakt

		KontaktMailer.kontakt(params[:email], params[:besked], params[:emne]).deliver

		flash[:notice] = "Din besked '#{params[:emne]}' er blevet sendt"
		redirect_to root_path
	end


	private

	def is_user_signed_in?
		if user_signed_in?
			flash[:notice] = "Du er allerede logget ind"
			redirect_to user_path(current_user.id)
		end
	end
end
