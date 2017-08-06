class QuestionsController < ApplicationController


	def show
		# Har user stemt på det her før?
		if vote = current_user.votes.detect{|v| v.question_id == params[:id].to_i}
			@user_vote = vote
		else
			@user_vote = nil
		end

		@question = Question.find(params[:id])
		
	end

	def index
		@questions = Question.vote_count_sort
		
	end
	def new
		@question = Question.new()
	end

	def create
		@question = Question.new(question_params)

		if @question.save 
			flash[:notice] = "\"#{@question.headline}\" er blevet gemt."
			redirect_to show_questions_path()
		else
			redirect_to new_question_path(), notice: @question.errors[:text]
		end 
	end
	
	def edit
		@question = Question.find(params[:id])
	end

	def update
		@question = Question.find(params[:id])
		if @question.update(question_params)
			redirect_to show_questions_path(), notice: "\"#{@question.headline}\" er blevet opdateret"
		else
			render 'edit'
		end
	end

	def destroy
		@question = Question.find(params[:id])

		if @question.destroy
			redirect_to show_questions_path(), notice: "\"#{@question.headline}\" er blevet slettet"
		end
		
	end

	private

	def question_params
		params.require(:question).permit(:headline, :text)
	end
end
