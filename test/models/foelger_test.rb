require 'test_helper'

class FoelgerTest < ActiveSupport::TestCase

	def setup
		# First user is following last user
		@foelger = Foelger.new(follower_id: users(:peter).id, followed_id: users(:frederik).id)		
	end

	test "should be valid" do
		assert @foelger.valid?
	end

	test "should require a follower_id" do
		@foelger.follower_id = nil
		assert_not @foelger.valid?
	end

	test "should require a followed_id" do
		@foelger.followed_id = nil
		assert_not @foelger.valid?
	end

end
