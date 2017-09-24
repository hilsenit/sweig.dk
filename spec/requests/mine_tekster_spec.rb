require 'rails_helper'


RSpec.describe "MineTeksterFunctionality" do
	let(:user) {create(:user, :works)}
	let(:active_user) {create(:user, :works)}

	it "should show under kladder when KLADDEt and otherwise with UDGIV" do
		log_user_in user
		work = user.works.first
		fill_work user, work # Udfyld et nyt værks felter
		find(:css, '#saveAsDraft').click # Push GEM SOM KLADDE
		expect(page).to have_content("'#{work.title}' er blevet gem som kladde")
		visit user_my_works_path(user.friendly_id)
		within(".drafts") { expect(page).to have_content("#{work.title}") }
	end

	it "should show under UDGIV when work is published" do
		log_user_in user
		work = user.works.first
		fill_work user, work # Udfyld et nyt værks felter
		find(:css, '#saveAsPublic').click # Push UDGIV
		expect(page).to have_content("'#{work.title}' er blevet udgivet")
		visit user_my_works_path(user.friendly_id)
		within(".public") { expect(page).to have_content("#{work.title}") }
	end

	it "should move when pushing UDGIV/KLADDE" do
		log_user_in user
		visit user_my_works_path(user.friendly_id)
		within(".drafts") { find(:css, '.udgiv', match: :first).click } 
		within(".public") { expect(page).to have_content(user.works.first.title) } 
		# And back again
		visit user_my_works_path(user.friendly_id) # No js
		within(".public") { find(:css, '.kladde', match: :first).click }
		within(".drafts") { expect(page).to have_content(user.works.first.title) }
	end


end