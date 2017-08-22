class UsersController < ApplicationController
	before_action :newest_and_most_read_works, only: [:show, :saved_works]

	def show
		#Biblo
		@user = User.friendly.find(params[:user_id])
		@published_works = @user.works.published_works
		if current_user && @user.id == current_user.id
			@biblo = @user.biblo
			render 'show'
		else
			@saved_works = []
			@user.saved_works.each do |saved_work|
				@saved_works << Work.find(saved_work.work_id)
			end

			render 'show_another_user'
		end


	end

	def my_works # Mine værker
		@user = User.friendly.find(params[:user_id])
		@published_works = @user.works.published
		@draft_works = @user.works.draft
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)

		if @user.save
			redirect_to user_path(@user.friendly_id), notice: "Din profil er nu blevet oprettet"
		else
			render "new", notice: "Det lykkedes desværre ikke."
		end
		
	end

	def index 
		if user_signed_in?
			flash[:notice] = "Du er allerede logget ind"
			redirect_to user_path(current_user.friendly_id)
		else
			render "devise/registrations/new"
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
	end


	def save_work_for_current_user
		work = Work.friendly.find(params[:work_id])
		user = User.friendly.find(params[:user_id])
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
		current_user.saved_works.each {|s_w| s_w.delete if s_w.work_id == work.id }
		flash[:notice] = "'#{work.title}' er nu slettet fra dine gemte under MIT"
		redirect_to user_work_path(user, work)
	end

	def follow 
		@user = User.friendly.find(params[:id])
		current_user.follow @user 
		@message = "Du FOELGER nu #{@user.username.parameterize}" 
		respond_to do |format| 
			format.js { render 'users/js/follow' }
		end
	end

	def unfollow 
		@user = User.friendly.find(params[:id])
		current_user.unfollow @user
		@message = "Du FOELGER ikke længere #{@user.username.parameterize}" 
		respond_to do |format| 
			format.js { render 'users/js/unfollow' }
		end

	end

	def followers
		@user = User.friendly.find(params[:id])
		@followers = @user.followers
		@following = false 
		respond_to do |format|
			format.js {render 'users/js/followers' }
		end
	end

	def following
		@user = User.friendly.find(params[:id])
		@followers = @user.following
		@following = true
		respond_to do |format|
			format.js {render 'users/js/followers' }
		end		
	end

	def saved_works
		@user = User.friendly.find(params[:user_id])
		@saved_works = []
		@user.saved_works.each do |saved_work|
			@saved_works << Work.find(saved_work.work_id)
		end
		
	end


	private

	def newest_and_most_read_works
		published_works = Work.where(status: 1)
		@newest_works = published_works.order(created_at: :desc).limit(12)
		@most_read_works = published_works.order(views: :desc).limit(12)		
	end

	def user_params
		params.require(:user).permit(:username, :email)
	end
end
