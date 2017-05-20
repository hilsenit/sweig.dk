class WorksController < ApplicationController
	layout "reader", only: :show 


	def index
		@works = Work.all
		if params[:search] #This is what the user is searching for
			@works = Work.search(params[:search]).order(created_at: :desc)
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
		@work.published! if params[:status] == "published" 
		byebug
		if @work.save
			redirect_to user_path(@user), notice: "#{@work.title} er blevet gemt"
		else	
			render "new", notice: "Det lykkedes desværre ikke. Prøv igen."
		end
	end

	def show 
		@work = Work.friendly.find(params[:id])		
		@user = @work.user
	end


	private



	def work_params
		params.require(:work).permit(:title, :body )
	end

end
