require 'test_helper'

class WorkTest < ActiveSupport::TestCase
	test "work should be invalid without a title" do
		works(:one).title = nil
		assert_nil works(:one).title
		assert_not works(:one).valid?
	end 

	test "work should be invalid without a body" do
		works(:one).body = nil
		assert_nil works(:one).body
		assert_not works(:one).valid?
	end

	test "work should be invalid with empty title" do
		works(:one).title = ""
		assert_empty works(:one).title
		assert_not works(:one).valid?
	end

	test "work should be invalid with empty body" do
		works(:one).body = ""
		assert_empty works(:one).body
		assert_not works(:one).valid?
	end

	test "work should be valid with a body and a title but no marks" do
		works(:one).all_tags_in_s = ""
		assert_empty works(:one).all_tags_in_s
		assert works(:one).valid?
	end 

	test "work should be invalid without a user" do 
		works(:one).user = nil
		assert_nil works(:one).user
		assert_not works(:one).valid?
	end

end

