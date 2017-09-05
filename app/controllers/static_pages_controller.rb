class StaticPagesController < ApplicationController
	before_action :is_user_signed_in?, only: [:log_in, :oprettelse]
	def index
	end

	def redirect
		if current_user
			flash[:notice] = "Velkommen tilbage #{current_user.username}"
			redirect_to user_biblo_path(current_user.id)
		else 
			redirect_to forside_path()
		end
	end

	def find
		@newest_works = Work.limit(8)
	end

	def nyeste 
		@newest_works = Work.limit(24)
		
	end

	def alle_maerker 
		@maerker = Mark.all
	end

	def show_maeker_works
		@works = Mark.find(params[:maerker_id]).works
		respond_to do |format|
			format.js
		end 
	end
	def search
		published_work = Work.where(status: 1)
		@users = User.search(params[:search]).order(created_at: :desc).limit(12) 
		@works = published_work.search(params[:search]).order(created_at: :desc).limit(12)
		respond_to do |format|
			format.js
			format.html
		end		
	end
		
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
