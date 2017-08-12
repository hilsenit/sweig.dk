class SharedController < ApplicationController
	def not_logged_in
		@message = params[:message]

		respond_to do |format|
			format.js

		end
	end
end
