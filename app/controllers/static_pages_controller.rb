class StaticPagesController < ApplicationController
	layout "countdown", only: [:redirect]
	before_action :is_user_signed_in?, only: [:log_in, :oprettelse]

	def index
		@head_title = "Velkommen"
    @works = Work.published.sample(8)
	end

	def moede_raad;end

	def redirect
		@head_title = "Velkommen"
		if current_user
			flash[:notice] = "Velkommen"
			redirect_to user_biblo_path(current_user.friendly_id)
		else
			redirect_to forside_path()
		end
	end

	def laes
		@head_title = "Læs værker"
		@works = Work.published.includes(:marks, :user)
	end

	def fremtidsvision
		@head_title = "Fremtidsvision"
	end

	def info
		@head_title = "Information"
	end

	def kontakt_vindue
		@head_title = "Kontakt os"
	end

	def nyeste
		@head_title = "Nyeste værker"
		@newest_works = Work.published.page params[:page]
	end

	def alle_maerker
		@head_title = "Alle mærker"
		@maerker = Mark.all
	end

	def show_maerke_works
		@maerke = Mark.find(params[:maerker_id])
		@head_title = "Mærke: #{@maerke.title}"
		@works = @maerke.works
		respond_to do |format|
			format.js
		end
	end

	def show_maerke_works_link
		@maerker = Mark.all
		@maerke = Mark.friendly.find(params[:maerker_id])
		@head_title = "Visning af #{@maerke.title} værker"
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

	def kontakt
		params[:kontakt].each do |key, val|
			if val.empty?
				redirect_to kontakt_path(), notice: "#{key.capitalize} er tom. Prøv igen."
				return
			end
		end
		KontaktMailer.kontakt(params[:kontakt][:email], params[:kontakt][:emne], params[:kontakt][:besked]).deliver
		flash[:notice] = "Din besked '#{params[:kontakt][:emne]}' er blevet sendt"
		redirect_to kontakt_path()
	end

	private

	def is_user_signed_in?
		if user_signed_in?
			flash[:notice] = "Du er allerede logget ind"
			redirect_to user_path(current_user.id)
		end
	end
end
