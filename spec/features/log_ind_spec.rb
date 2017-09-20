require 'rails_helper'

RSpec.feature "Log Ind" do 

	scenario "check that users should be confirmed to log in" do
		user = create(:user)
		log_user_in user, without_confirmation: true 		 # See user_action module
		expect(page).to have_current_path(new_user_session_path())
		expect(page).to have_content("Du bliver nødt til at aktivere via din mail")
	end

	scenario "check that users can log in when confirmed" do
		user = create(:user)
		log_user_in user # See user_action module
		expect(page).to have_current_path(user_biblo_path(user.friendly_id))
		expect(page).to have_content("Du er nu logget ind")
	end

end