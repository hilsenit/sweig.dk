require 'rails_helper'

RSpec.describe "Event" do
  let(:user) {create(:user, :works)}
  let(:admin_user) {create(:user, :admin)}
  let(:event) {create(:event)}

  it "should be possible to create events from the admin page" do
    log_user_in admin_user
    expect(page).to have_content("Opret oplæsning")
    click_link("Opret oplæsning")
    expect(current_path).to eq(new_user_event_path(admin_user.friendly_id))
    expect(page).to have_content("Opret oplæsning")
  end

  it "should not be possible for normal users right now" do
    log_user_in user
    visit new_user_event_path(user.friendly_id)
    expect(current_path).to eq(user_biblo_path(user.friendly_id))
  end

  it "should have fields for each of the attributes" do
    log_user_in admin_user
    visit new_user_event_path(admin_user.friendly_id)
    fill_in "event[title]", with: event.title
    fill_in "event[body]", with: event.body
    fill_in "event[address]", with: event.address
    fill_in "event[date]", with: event.date
    fill_in "event[img]", with: "https://thumb1.shutterstock.com/display_pic_with_logo/2266028/215730313/stock-vector-link-icon-215730313.jpg"
    click_button "Opret oplæsning"
    # Arbejd videre på senere
    # expect(current_path).to eq(view_events_path)
    # expect(page).to have_content("er blevet oprettet")
  end

end
