require 'rails_helper'

RSpec.describe "PasswordResets", type: :request do
	it "sends user email when requstiong new password" do
		user = create(:user)
		visit new_user_session_path
		click_link "kodeord?"
		fill_in "user_email", with: user.email
		click_button "instruks"
		expect(page).to have_current_path(new_user_session_path())
		expect(page).to have_content("Du vil modtage en email")
		expect(last_user_email.to).to include(user.email)
	end 
end
