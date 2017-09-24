require 'rails_helper'


RSpec.describe "SamlingFunctionality" do
	let(:user) {create(:user, :works)}
	let(:active_user) {create(:user, :works)}

	it "work should be shown under SAMLING when saved" do
		log_user_in active_user
		first_work = user.works.first
		visit user_work_path(user.friendly_id, first_work.friendly_id)
		click_link "GEM"
		visit user_saved_works_path(active_user.friendly_id)
		within(".main") { expect(page).to have_content(first_work.title) }
	end

	# Afprøv slet-fra-gemte-knap, men kan ikke fa JS til at acceptere data-confirm vinduet!

end