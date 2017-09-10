class StaticPagesController < ApplicationController
	layout "countdown", only: [:redirect]
	before_action :is_user_signed_in?, only: [:log_in, :oprettelse]
	def index
	end
	
	def redirect
		if current_user
			flash[:notice] = "Velkommen"
			redirect_to user_biblo_path(current_user.friendly_id)
		end 
	end

	def laes
		@newest_works = Work.published.limit(8)
	end
	def fremtidsvision; end
	def info; end
	def kontakt_vindue; end

	def nyeste 
		@newest_works = Work.published.limit(24)
		
	end

	def alle_maerker 
		@maerker = Mark.all
	end

	def show_maerke_works
		@maerke = Mark.find(params[:maerker_id])
		@works = @maerke.works
		respond_to do |format|
			format.js
		end 
	end

	def show_maerke_works_link
		@maerker = Mark.all
		@maerke = Mark.friendly.find(params[:maerker_id])
		@works = @maerke.works
		render "alle_maerker"
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
