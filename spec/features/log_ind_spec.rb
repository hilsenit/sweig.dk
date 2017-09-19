require 'rails_helper'

RSpec.feature "Log Ind" do 

	scenario "check that users should be confirmed to log in" do
		visit new_user_session_path()
		user = create(:user) # Without confirmation
		within("form") do
			fill_in "user[email]", with: user.email
			fill_in "user[password]", with: user.password
		end
		click_button "Log ind"
		expect(page).to have_current_path(new_user_session_path())
		expect(page).to have_content("Du bliver nødt til at aktivere via din mail")
	end

	scenario "check that users can log in when confirmed" do
		visit new_user_session_path()
		user = create(:user)
		user.confirmed_at = Time.now 
		user.save! # HUSK DET HER
		within("form") do
			fill_in "user[email]", with: user.email
			fill_in "user[password]", with: user.password
		end
		click_button("Log ind")
		expect(page).to have_current_path(user_biblo_path(user.friendly_id))
		expect(page).to have_content("Du er nu logget ind")
	end

end