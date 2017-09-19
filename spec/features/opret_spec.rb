require 'rails_helper'

RSpec.describe "CreateUser", type: :request do 
	let(:user) {build(:user)} # RSPEC helper method, defined before each call

	it "should send email when creating user" do
		visit new_user_registration_path()
		within("form") do
			fill_in "user[username]", with: user.username
			fill_in "user[email]", with: user.email
			fill_in "user[password]", with: user.password 
			fill_in "user[password_confirmation]", with: user.password
		end
		click_button "Opret mig nu"
		expect(last_user_email.body.encoded).to include(user.username)
		expect(last_user_email.to).to include(user.email)
		expect(page).to have_current_path(forside_path())
		expect(page).to have_content("En e-mail er blevet sendt. Aktiver din bruger via den.")
	end 

	it "should not be possible to have the same username with capital letters" do
		visit new_user_registration_path()
		user_created = create(:user)
		within("form") do
			fill_in "user[username]", with: user.username.upcase!
			fill_in "user[email]", with: "another@email.com"
			fill_in "user[password]", with: user.password 
			fill_in "user[password_confirmation]", with: user.password
		end
		click_button "Opret mig nu"
		expect(page).to have_current_path("/users") #Redirecter til users, hvad sker der på reload production-mode?
		expect(page).to have_content("er allerede brugt")
	end 

end