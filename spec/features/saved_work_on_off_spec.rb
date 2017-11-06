require 'rails_helper'

RSpec.feature 'ShowSavedWorksOnOff' do
# User is saving another users work
let(:user) {create(:user)}
let(:another_user) {create(:user, :works)}
let(:saved_work) { create(:saved_work, user_id: user.id, work_id: another_user.works.last.id) }

before(:each) {
  log_user_in user # user_actions module
  user.saved_works << saved_work # Hvorfor er det her nødvendigt?
}

  scenario "saved_work should be shown after saving and also by deafult to other users" do
    visit user_saved_works_path(user.friendly_id)
    within(".saved-works-wrapper") do
      expect(page).to have_content(another_user.works.last.title)
    end
    logout(:user)
    # Another user should see the saved work on users profile
    login_as(:user, scope: another_user)
    visit user_path(user.friendly_id)
    expect(page).to have_content(another_user.works.last.title)
  end

  scenario "turn privacy ON on your saved works and another user shouldn't be able to see them" do
    visit user_saved_works_path(user.friendly_id)
    find('[name="toggle_publicity"]').click
    logout(:user)
    login_as(:user, scope: another_user)
    visit user_path(user.friendly_id)
    expect(page).not_to have_content(another_user.works.last.title)
  end


end
