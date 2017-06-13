class WorksController < ApplicationController
	layout "reader", only: :show 
	layout "simple_view", only: [:new, :edit, :show]


	def index
		@works = Work.all
		if params[:search] #This is what the user is searching for
			@works = Work.search(params[:search]).order(created_at: :desc)
		end
		
	end

	def edit
		@user = User.friendly.find(params[:user_id])
		@work = Work.friendly.find(params[:id])
	end

	def update
		@work = Work.friendly.find(params[:id])
		if @work.update(work_params)
			redirect_to User.find(@work.user_id), notice: "#{@work.title} er blevet gemt."
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
			redirect_to user_path(@user), notice: "#{@work.title} er blevet gemt"
		else	
			render "new", notice: "Det lykkedes desværre ikke. Prøv igen."
		end
		
	end

	def show 
		@work = Work.friendly.find(params[:id])		
		@user = @work.user
	end

	def destroy
		@work = Work.friendly.find(params[:id])
		if @work.destroy
			redirect_to user_path User.friendly.find(@work.user_id), notice: "Dit værk er blevet slettet"
		else
			redirect_to @user, notice: "Det lykkedes ikke at slette dit værk."
		end
	end

	private



	def work_params
		params.require(:work).permit(:title, :body )
	end

end
