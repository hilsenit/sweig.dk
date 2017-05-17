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
		@work = @user.works.build
	end

	def create
		@work = Work.friendly.find(params[:id])		
		if @work.save
			redirect_to user_path(@work.user_id), notice: "#{@work.title} er blevet gemt"
		else	
			render "new", notice: "Det lykkedes desværre ikke. Prøv igen."
		end
	end

	def show 
		@user = @work.user
	end


	private



	def work_params
		params.require(:works).permit(:title, :body)
	end

end
