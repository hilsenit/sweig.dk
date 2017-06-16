class UsersController < ApplicationController

	def show
		@newest_work = Work.all.order(created_at: :desc).limit(12)
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
		flash[:notice] = "'#{work.title}' er nu gemt under MIT"
		redirect_to user_work_path(user, work)
	end

	def delete_saved_work
		user = User.friendly.find(params[:user_id])
		work = Work.friendly.find(params[:work_id])
		current_user = User.friendly.find(params[:current_user])
		# se hvilket af den besøgendes gemte værker, som er det viste værk
		# TODO Hvordan laver man den her i én linje?
		current_user.saved_works.each do |saved_work|
			if saved_work.work_id = work.id
				@this_saved_work = saved_work
			end
			# Hvordan går man ud af en each
		end
		@this_saved_work.delete
		flash[:notice] = "'#{work.title}' er nu slettet fra dine gemte under MIT"
		redirect_to user_work_path(user, work)
	end



	def saved_works
		@user = User.friendly.find(params[:user_id])
		@saved_works = []
		@user.saved_works.each do |saved_work|
			@saved_works << Work.find(saved_work.work_id)
		end
		
	end


	private

	def user_params
		params.require(:user).permit(:username, :email)
	end
end
