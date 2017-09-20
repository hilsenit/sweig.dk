module UserActions

	def log_user_in user, without_confirmation=false
		visit new_user_session_path()
		unless without_confirmation
			user.confirmed_at = Time.now 
			user.save! # HUSK DET HER
		end 
		within("form") do
			fill_in "user[email]", with: user.email
			fill_in "user[password]", with: user.password
		end
		click_button("Log ind")
	end


end 