class WorksController < ApplicationController
	before_action :tags_uppercase, only: [:update, :create]
	layout "simple_view", only: [:new, :edit, :show, :create]

	def index
		redirect_to new_user_work_path()
	end

	def edit
		@user = User.friendly.find(params[:user_id])
		@work = Work.friendly.find(params[:id])
	end

	def update
		@work = Work.friendly.find(params[:id])
		@user = @work.user
		old_tags = @work.all_tags_in_s
		binding.pry
		new_tags = params[:work][:all_tags_in_s].split(",")
		if @work.update(work_params)
			update_marks old_tags.split(","), new_tags, @work
			if params[:status] == "Udgiv" 
				@work.published!
			else
				@work.draft!
			end
			redirect_to user_my_works_path(@work.user_id), notice: "'#{@work.title}' er blevet gemt."
		else
			redirect_to edit_user_work_path(@user.id, @work.id), flash: {errors: @work.errors}
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
			@work.all_tags_in_s = params[:work][:all_tags_in_s]
			array = @work.all_tags_in_s.split(",")
			create_marks array, @work
			@work.published! if params[:status] == "Udgiv" 

			generate_biblo_story_work_publish @user, @work # Application controller method

			redirect_to user_my_works_path(@user), notice: "'#{@work.title}' er blevet gemt"
		else	
			render 'new'
		end
		
	end

	def show
		begin		
			@work = Work.friendly.find(params[:id])	
			work_views 	
			@user = @work.user
		rescue
			not_found
		end

	end

	def destroy
		@work = Work.friendly.find(params[:id])

		if @work.destroy
			redirect_to user_my_works_path User.friendly.find(@work.user_id), notice: "'#{@work.title}' er blevet slettet"
		else
			redirect_to user_my_works_path(@user), notice: "Det lykkedes ikke at slette '#{@work.title}'. Prøv igen."
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

	def create_marks array_of_marks, obj
		array_of_marks.each do |t|
			if Mark.new(title: t).valid? # Hvis det mærke med titel ikke allerede eksisterer i databasen?
				obj.marks << Mark.create(title: t)
			else #Læg værket ind i det allerede eksisterende mærke
				Mark.find_by_title(t).works << obj
			end 
		end 
	end

	def update_marks old_array, new_array, obj
		old_array.each do |o_a| # Delete mark if mark_title is not in new_array 
			obj.marks.delete(Mark.find_by_title(o_a)) unless new_array.include? o_a || obj.marks.empty?
		end
		#Hvis tags var i den gamle, så lad være med at tage dem med
		new_array.delete_if {|a| old_array.include? a} 
		create_marks new_array, obj
	end

	def tags_uppercase
		unless params[:work][:all_tags_in_s].nil?
			array = params[:work][:all_tags_in_s].split(",")
			array.map! do |tag|
				tag.strip!
				tag = tag.upcase
			end
			params[:work][:all_tags_in_s] = array.join(",")
			binding.pry
		end
	end

# PARAMS	
	def work_params
		params.require(:work).permit(:title, :body, :username, :all_tags_in_s)
	end

end
