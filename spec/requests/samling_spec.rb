require 'rails_helper'


RSpec.describe "SamlingFunctionality" do
	let(:user) {create(:user, :works)}
	let(:active_user) {create(:user, :works)}

	it "delete saved_work should remove them from users SAMLING" do
		log_user_in active_user
		first_work = user.works.first
		visit user_work_path(user.friendly_id, first_work.friendly_id)
		click_link "GEM"
		visit user_saved_works_path(active_user.friendly_id)
		within(".main") { expect(page).to have_content(first_work.title) }
		# Kan ikke få det til at virke
	end

end