class UsersController < ApplicationController
	before_action :find_user, only: [ :show ]
	def show
		@works = @user.works
		
	end

	private

	def find_user 
		@user = User.friendly.find(params[:id])
	end
end
