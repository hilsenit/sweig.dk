class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@works = @user.works
	end
end
