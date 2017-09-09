class UsersController < ApplicationController
	before_action :authenticate_user!, except: [:show]
	def biblo
		@user = User.friendly.find(params[:user_id])
		unless @user.id == current_user.id 
			redirect_to user_path(@user.friendly_id)
		else
			flash.now[:notice] = "Det du har prøvet at finde er enten slettet eller kladdet, desværre." if params[:not_found]
			@stories = @user.stories.limit(10)
			@stories_length = @user.stories.size
		end
	end

	def show
		begin 
			@user = User.friendly.find(params[:id])
			@published_works = @user.works.published_works
			@saved_works = []
			@user.saved_works.each do |saved_work|
				@saved_works << Work.find(saved_work.work_id)
			end
		rescue
			not_found
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
		generate_biblo_save current_user, user, work.slug, work.title
		new_saved_work = SavedWork.new(user_id: current_user.id, work_id: work.id)
		new_saved_work.save!
		flash[:notice] = "'#{work.title}' er nu gemt under SAMLING"
		redirect_to user_work_path(user, work)
	end

	def delete_saved_work
		user = User.friendly.find(params[:user_id])
		work = Work.friendly.find(params[:work_id])
		current_user.saved_works.each {|s_w| s_w.delete if s_w.work_id == work.id }
		flash[:notice] = "'#{work.title}' er nu slettet fra dine gemte under SAMLING"
		redirect_to user_work_path(user, work)
	end

	def follow 
		@user = User.friendly.find(params[:id])
		current_user.follow @user 
		generate_biblo_follow current_user, @user
		@message = "Du FØLGER nu #{@user.username.parameterize}" 
		respond_to do |format| 
			format.js { render 'users/js/follow' }
		end
	end

	def unfollow 
		@user = User.friendly.find(params[:id])
		current_user.unfollow @user
		@message = "Du FØLGER ikke længere #{@user.username.parameterize}" 
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

	def user_params
		params.require(:user).permit(:username, :email, :remember_me)
	end
end
