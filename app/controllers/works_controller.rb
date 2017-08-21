class WorksController < ApplicationController
	
	before_action :newest_and_most_read_works, only: [:new]
	layout "simple_view", only: [:new, :edit, :show, :create]

	def index
		# UNderligt hack for create action render 'new' problemet med, at den går til index, hvis den ikke gemmer
		redirect_to new_user_work_path()
	end

	def edit
		@user = User.friendly.find(params[:user_id])
		@work = Work.friendly.find(params[:id])

	end

	def update
		@work = Work.friendly.find(params[:id])
		if @work.update(work_params)
			if params[:status] == "Udgiv" 
				@work.published!
			else
				@work.draft!
			end
			redirect_to user_my_works_path(@work.user_id), notice: "'#{@work.title}' er blevet gemt."
		else
			redirect_to user_my_works_path(@work.user_id), error: "'#{@work.title}' blev ikke gemt. Prøv igen. " 
		end
	end
	
	def new
		@user = User.friendly.find(params[:user_id])
		@work = @user.works.build(user_id: @user.id)
	end

	def create
		@work = Work.new(work_params)
		@user = User.friendly.find(params[:user_id])
		@work.user_id = @user.id
		
		if @work.save
			@work.published! if params[:status] == "Udgiv" 
			redirect_to user_my_works_path(@user), notice: "'#{@work.title}' er blevet gemt"
		else	
			render 'new'
		end
		
	end

	def show

		@work = Work.friendly.find(params[:id])	
		work_views 	
		@user = @work.user
	end

	def destroy
		@work = Work.friendly.find(params[:id])

		if @work.destroy
			redirect_to user_my_works_path User.friendly.find(@work.user_id), notice: "Dit værk er blevet slettet"
		else
			redirect_to user_my_works_path(@user), notice: "Det lykkedes ikke at slette dit værk."
		end
	end

	private

	def work_views
		if @work.views.nil?
			@work.views = 1
		else
			@work.views += 1
		end
		@work.save!
	end

	def newest_and_most_read_works
		published_works = Work.where(status: 1)
		@newest_works = published_works.order(created_at: :desc).limit(12)
		@most_read_works = published_works.order(views: :desc).limit(12)				
	end

	def work_params
		params.require(:work).permit(:title, :body, :username)
	end

end
