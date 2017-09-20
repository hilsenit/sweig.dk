require 'rails_helper'

RSpec.describe "UserProfile" do 
	let(:user) {create(:user, :works)}

	it "should not be possible for another user to visit the user-profile pages" do
		user_visiting = create(:user) # The user trying to visit 
		log_user_in user_visiting
		%w(user_biblo user_saved_works user_my_works new_user_work).each do |path|
			visit eval("#{path}_path(user.friendly_id)") 
			expect(page).to have_current_path(user_path(user.friendly_id))
			expect(page).to have_content("Du kan ikke besøge")
		end 
		visit edit_user_work_path(user.friendly_id, user.works.first.friendly_id) # Opret værk
		expect(page).to have_current_path(user_path(user.friendly_id))
		expect(page).to have_content("Du kan ikke besøge")
	end


	
end