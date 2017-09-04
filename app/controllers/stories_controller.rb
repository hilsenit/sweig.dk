class StoriesController < ApplicationController


	def destroy
		@user = User.find(params[:user_id])
		@story = Story.find(params[:id])
		if @story.destroy
			@story_id = "#" + @story.id.to_s
			respond_to do |format|
				format.js
			end
		else
			redirect_to user_biblo_path(@user.friendly_id), flash: {notice: "Noget gik galt, det var ikke muligt at slette den del af din Biblo"}
		end
	end

	def load_more
		@user = User.find(params[:user_id])
		stories = params[:story_count].to_i
		@stories = @user.stories.offset(stories).limit(10)
		if stories + 10 > @user.stories.length 
			@remove_button = true 
		end 
		@next_stories_size = stories + 10 # For the button :story_count
		respond_to do |format|
			format.js
		end
	end
end
