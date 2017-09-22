require 'rails_helper'

RSpec.describe "BibloFunctionality" do 
	let(:user) {create(:user, :works)}
	let(:active_user) {create(:user, :works)}


	it "biblo should be updated with save-message when saving work and saved work should be shown to active user" do
		log_user_in active_user

		first_work = user.works.first
		visit user_work_path(user.friendly_id, first_work.friendly_id)
		click_link "GEM"
		within(".show-navbar") do
			expect(page).to have_content("'#{first_work.title}' er nu gemt")
		end

		visit user_biblo_path(active_user.friendly_id)
		within(".biblo-wrapper") do
			expect(page).to have_content("Du har gemt #{first_work.title}")
		end

		# Checking if saved work is shown under SAMLING for active user
		visit user_saved_works_path(active_user.friendly_id) 
		within(".main") do
			expect(page).to have_content(user.username.parameterize)
			expect(page).to have_content(first_work.title)
		end 

		log_user_out # Active user logged out
		log_user_in user # Inactive user log in
		# Check inactive user biblo if updated?
		visit user_biblo_path(user.friendly_id) 
		within(".biblo-wrapper") do
			expect(page).to have_content("#{active_user.username} har gemt dit værk")
		end

	end


	it "follow should g message on inactive and active users biblo and model action should work" do
		log_user_in active_user
		visit user_path(user.friendly_id)
		click_link("FØLG")
		# Check model actions
		assert_same (active_user.following? user), true
		assert_same (user.followers? active_user), true

		expect(page).to have_content("Du FØLGER nu")
		visit user_biblo_path(active_user.friendly_id)
		within(".biblo-wrapper") do
			expect(page).to have_content("Du følger nu #{user.username}")
		end
		log_user_out
		log_user_in user
		visit user_biblo_path(user.friendly_id) 
		within(".biblo-wrapper") do
			expect(page).to have_content("#{active_user.username} følger dig nu")
		end
	end


end