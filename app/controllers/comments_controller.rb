class CommentsController < ApplicationController

	def new
		question = Question.find(params[:question_id])
		@comment = Comment.new(question_id: question.id)
		respond_to do |format|
			format.js
		end 

	end

	def create 
		question_id = Question.find(params[:question_id]).id
		@comment = Comment.new(comment_params)
		if @comment.save
			respond_to do |format|
				format.js
			end
		else
			redirect_to questions_path(question_id), notice: "Din kommentar blev ikke gemt. Prøv igen"
		end 
	end

	private

	def comment_params
		params.require(:comment).permit(:text, :question_id)
	end
						

end
