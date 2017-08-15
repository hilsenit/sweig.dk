class CommentsController < ApplicationController

	def new
		@question = Question.find(params[:question_id])
		@comment = Comment.new(question_id: @question.id)
		respond_to do |format|
			format.js
		end 

	end

	def create 
		@question = Question.find(params[:question_id])
		@comment = Comment.new(comment_params)
		@comment.user_id = params[:comment][:user_id]
		@comment.question_id = @question.id
		@comments = @question.comments
		if @comment.save
			respond_to do |format|
				format.js
			end
		else
			@error_message = @comment.errors.full_messages.first
			respond_to do |format|
				format.js {render "comment_error"}
			end
		end 
	end

	private

	def comment_params
		params.require(:comment).permit(:text, :question_id, :user_id)
	end
						

end
