class QuestionsController < ApplicationController


	def show
		flash[:notice] = "Her kan du afgive din stemme på spørgsmålet."
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
			redirect_to show_questions_path(), notive: "\"#{@question.headline}\" er blevet slettet"
		end
		
	end

	def destroy
		@vote = Vote.find(params[:id])
		if @vote.destroy
			@message = "Din stemme er blevet fjernet"
			respond_to do |format|
				format.js { render 'message' }
			end
		end
	end

	def vote
		@question = Question.find(params[:question_id])
		@user_vote = Vote.new(question_id: @question.id, user_id: current_user.id)
		if @user_vote.save
			if params[:value] == "up"
				@user_vote.vote_num = 1
				@question.vote_count += 1
			else 
				@user_vote.vote_num = 0
				@question.vote_count += -1
			end 
			@question.save!; @user_vote.save!

			respond_to do |format|
				format.js 
			end
		else
			@message = "Du kan kun stemme én gang på hvert spørgsmål"
			respond_to do |format|
				format.js { render 'message' }
			end
		end
	end

	private

	def question_params
		params.require(:question).permit(:headline, :text)
	end
end
