require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "user model active_relationships following, followers, followed methods should work" do
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

  test "user username shoul be uniq" do
    users(:frederik).password = "password"
    assert users(:frederik).valid?
    users(:frederik).username = "peter"
    assert_equal "peter", users(:frederik).username
    assert_not users(:frederik).valid?
  end

  test "email should be uniq" do 
    users(:frederik).password = "password"
    users(:frederik).username = "peter"
    assert_equal "peter", users(:frederik).username
    assert_not users(:frederik).valid?
  end

  test "password should be present" do
    users(:henrik).password = ""
    assert_empty users(:henrik).password
    assert_not users(:henrik).valid?
  end


  test "username should be present" do
    users(:peter).password = "password"
    users(:peter).username = ""
    assert_empty users(:peter).username
    assert_not users(:peter).valid?
  end

  test "email should be present" do
    users(:peter).password = "password"
    users(:peter).email = ""
    assert_empty users(:peter).email
    assert_not users(:peter).valid?
  end 




end
