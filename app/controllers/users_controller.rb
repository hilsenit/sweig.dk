class UsersController < ApplicationController
	layout "user"
	def show
		@user = User.friendly.find(params[:id])
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


	def save_work_for_current_user
		work = Work.friendly.find(params[:work_id])
		user = User.friendly.find(params[:user_id])
		current_user = User.friendly.find(params[:current_user])
		new_saved_work = SavedWork.new
		new_saved_work.user = current_user
		new_saved_work.work = work
		new_saved_work.save!
		redirect_to user_work_path(user, work)
	end

	def remove_saved_work
		@work = Work.friendly.find(params[:work_id])


		
	end



	private

	def user_params
		params.require(:user).permit(:username, :email)
	end
end
