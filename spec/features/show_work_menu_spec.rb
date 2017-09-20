require 'rails_helper'


RSpec.describe "LæseVindue" do
	let(:user) {create(:user, :works)}
	let(:work) {user.works.first}

	it "et værk skal vise sin titel og tekst" do
		visit user_work_path(user.friendly_id, work.friendly_id)
		expect(page).to have_content(work.title)
		expect(page).to have_content(work.body) 
	end

	it "værks menu uden MIT og GEM ved not logged-in users" do
		visit user_work_path(user.friendly_id, work.friendly_id)
		within(".show-navbar") do 
			expect(page).not_to have_content("MIT")
			expect(page).not_to have_content("GEM")
			expect(page).to have_content("LÆS")
			expect(page).to have_content(work.username)
		end 
		#mobile
		within(".mit-menu") do
			expect(page).not_to have_content("GEM")
			expect(page).not_to have_content("BIBLO")
			expect(page).not_to have_content("SAMLING")
			expect(page).not_to have_content("MINE TEKSTER")
			expect(page).not_to have_content("OPRET VÆRK")
			expect(page).to have_content(work.username)
		end 
	end 

	it "værks menu skal have MIT, men ikke GEM, besøg eget værk" do
		log_user_in work.user 
		visit user_work_path(user.friendly_id, work.friendly_id)
		within(".show-navbar") do 
			expect(page).to have_content("MIT")
			expect(page).not_to have_content("GEM")
			expect(page).to have_content("LÆS")
			expect(page).to have_content(work.username)
		end 
		#mobile

		within(".mit-menu") do
			expect(page).not_to have_content("GEM")
			expect(page).to have_content("BIBLO")
			expect(page).to have_content("SAMLING")
			expect(page).to have_content("MINE TEKSTER")
			expect(page).to have_content("OPRET VÆRK")
			expect(page).to have_content("LÆS")
			expect(page).to have_content("REDIGER")
			expect(page).to have_content(work.username)
		end 

	end

	it "GEM skal blive vist, når værket ikke er mit" do
		first_user = user
		second_user = create(:user, :works)
		second_user_work = second_user.works.first
		log_user_in first_user # Den første bruger logger ind og besøger en andens værk
		visit user_work_path(second_user.friendly_id, second_user_work.friendly_id)	
		within(".show-navbar") do
			expect(page).to have_content("GEM")
		end
		within(".mit-menu") do #Mobilmenu
			expect(page).to have_content("GEM TIL DIN SAMLING")
		end

		click_link "GEM"

		within(".show-navbar") do
			expect(page).to have_content("er nu gemt under SAMLING")
			expect(page).to have_content("GEMT")
		end
		within(".mit-menu") do #Mobilmenu
			expect(page).to have_content("SLET FRA DINE GEMTE")
		end 

	end



end 