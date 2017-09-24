require 'rails_helper'

RSpec.describe "ReadWindow" do
	let(:user) {create(:user, :works)}
	let(:active_user) {create(:user, :works)}

	it "your own work should not be showing GEM" do
		log_user_in active_user
		first_work = active_user.works.first
		visit user_work_path(active_user.friendly_id, first_work.friendly_id)
		expect(find(".show-navbar")).not_to have_content("GEM")
		expect(find(".mit-menu")).not_to have_content("GEM TIL DIN SAMLING")
	end

	it "check if after saved work, GEM button changes" do
		log_user_in active_user
		first_work = user.works.first
		visit user_work_path(user.friendly_id, first_work.friendly_id)
		click_link "GEM"
		visit user_work_path(user.friendly_id, first_work.friendly_id)
		expect(find(".show-navbar")).to have_content("GEMT")
		expect(find(".mit-menu")).to have_content("SLET FRA DINE GEMTE") #Mobile menu
	end 

	it "should not be showing logged-in func. to not-logged-in users" do
		first_work = user.works.first
		visit user_work_path(user.friendly_id, first_work.friendly_id)
		expect(find(".show-navbar")).not_to have_content("MIT")
		within(".mit-menu") do
			expect(page).not_to have_content("GEM")
			expect(page).not_to have_content("BIBLO")
			expect(page).not_to have_content("SAMLING")
			expect(page).not_to have_content("MINE TEKSTER")
			expect(page).not_to have_content("GEM TIL DIN SAMLING")
		end 
	end


end