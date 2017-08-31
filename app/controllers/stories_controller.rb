class StoriesController < ApplicationController


	def destroy
		@user = User.find(params[:user_id])
		@story = Story.find(params[:id])
		if @story.destroy
			redirect_to user_biblo_path(@user.friendly_id), flash: {notice: "En lille del af din Biblo er nu slettet"}
		else
			redirect_to user_biblo_path(@user.friendly_id), flash: {notice: "Noget gik galt, det var ikke muligt at slette den del af din Biblo"}
		end
	end
end
