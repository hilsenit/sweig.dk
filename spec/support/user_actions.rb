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

	def fill_work user, work
		visit new_user_work_path(user.friendly_id)
		within("form") do
			fill_in "work[title]", with: work.title  
			fill_in "work[body]", with: work.body  
			fill_in "work[all_tags_in_s]", with: "EKSEMPEL PÅ MÆRKE,"
		end			
	end
	
	def log_user_out 
		within(" .frontpage-navbar-wrapper") do
			click_link("LOG UD")
		end
	end 

end 