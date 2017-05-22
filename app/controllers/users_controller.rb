class UsersController < ApplicationController
	before_action :find_user, only: [ :show ]
	def show
		@published_works = @user.works.published
		@draft_works = @user.works.draft
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)

		if @user.save
			redirect_to @user, notice: "Din profil er nu blevet oprettet"
		else
			render "new", notice: "Det lykkedes desværre ikke."
		end
		
	end
	def toggle_status
		# work_id as a params is only used on this route (se routes.rb)
		@work = Work.friendly.find(params[:work_id])
		if @work.published?
			@work.draft!
		else
			@work.published!
		end
		redirect_back(fallback_location: user_path(@work.user))

		# Kan måske bruges senere til AJAX af en art
		# respond_to do |format|
		#   format.js {render inline: "location.reload();" }
		# end
end


	private

	def find_user 
		@user = User.friendly.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:name, :email)
	end
end
