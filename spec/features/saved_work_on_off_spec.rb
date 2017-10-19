require 'rails_helper'

RSpec.feature 'ShowSavedWorksOnOff' do

let(:user) {create(:user)}
let(:another_user) {create(:user, :works)}
let(:saved_work) { create(:saved_work, user_id: user.id, work_id: another_user.works.last.id) }

before(:each) {
  log_user_in user
  user.saved_works << saved_work # Det her er nødvendigt?
}

  scenario "saved_work should be shown after saving and also by deafult to other users" do
    visit user_saved_works_path(user.friendly_id)
    within(".saved-works-wrapper") do
      expect(page).to have_content(another_user.works.last.title)
    end
    logout(user)
  end


end
