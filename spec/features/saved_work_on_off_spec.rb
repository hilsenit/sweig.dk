require 'rails_helper'

RSpec.feature 'ShowSavedWorksOnOff' do
  before(:each) do
    binding.pry
    @user = create(:user)
    @another_user = create(:user, :works)
    @saved_work = create(:saved_work, user_id: @user.id, work_id: @another_user.works.last.id)
  end

# let(:user) {create(:user)}
# let(:another_user) {create(:user, :works)}
# let(:saved_work) { create(:saved_work, user_id: user.id, work_id: another_user.works.last.id) }

  scenario "user should have the ability to hide saved works for other users" do
    log_user_in @user
    visit user_saved_works_path(@user.friendly_id)
    within(".saved-works-wrapper") do
      expect(page).to have_content(@another_user.works.last.title)
    end
  end

end
