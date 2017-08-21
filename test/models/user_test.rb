require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "user model active_relationships methods should work" do
  	peter = users(:peter)
  	frederik = users(:frederik)
  	assert_not peter.following?(frederik)
  	peter.follow(frederik)
  	assert peter.following?(frederik)
  	# New followers method
  	assert frederik.followers?(peter), "followers not working"
  	peter.unfollow(frederik)
  	assert_not peter.following?(frederik)
  end

end
