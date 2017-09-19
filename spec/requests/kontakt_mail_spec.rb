require 'rails_helper'

RSpec.describe "KontaktMailSent", type: :request do
	it "should return notice without email" do
		visit kontakt_path()
		within("form") do
			fill_in "kontakt[email]", with: ""
			fill_in "kontakt[emne]", with: "howdi"
			fill_in "kontakt[besked]", with: "nu skal du bare høre"
		end
		click_button "Send besked"
		expect(page).not_to have_content("Din besked 'howdi' er blevet sendt")
		expect(page).to have_content("Email er tom. Prøv igen.")
	end

	it "should send email with all fields filled" do 
		visit kontakt_path()
		user = create(:user)
		within("form") do
			fill_in "kontakt[email]", with: user.email
			fill_in "kontakt[emne]", with: "subject baby"
			fill_in "kontakt[besked]", with: "nu skal du bare høre kammerat!"
		end
		click_button "Send besked"
		expect(page).to have_content("Din besked 'subject baby' er blevet sendt")
		expect(last_user_email.from).to include(user.email)
		expect(last_user_email.to).to include("kontakt@sweig.dk")
		expect(last_user_email.subject).to include("subject baby")
	end



end