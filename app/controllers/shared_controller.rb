class SharedController < ApplicationController
	def not_logged_in
		@message = params[:message]
		@message = "For at fortsætte bliver du nødt til at logge ind, eller at oprette dig." if @message.empty?
		respond_to do |format|
			format.js

		end
	end
end
