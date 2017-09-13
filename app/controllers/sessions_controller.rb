class SessionsController < Devise::SessionsController
	def new
		@head_title = "Log ind"
		super
	end
end
