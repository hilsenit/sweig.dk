class QuestionsController < ApplicationController


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
			redirect_to show_questions_path(), notive: "\"#{@question.headline}\" er blevet slettet"
		end
		
	end

	def vote
		question = Question.find(params[:question_id])
		vote = Vote.create!(question_id: question.id)
		if params[:value] == "up"
			vote.vote_num = 1
			question.vote_count += 1
		else 
			vote.vote_num = 0
			question.vote_count += -1
		end 
		question.save!
		vote.save!
		@questions = Question.vote_count_sort
		message = "Tak for din stemme!"
		respond_to do |format|
			format.js { flash.now[:notice] = message }
		end
	end

	private
	def set_vote_and_count up_down
	end

	def question_params
		params.require(:question).permit(:headline, :text)
	end
end
