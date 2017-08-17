require 'test_helper'

class WorkTest < ActiveSupport::TestCase
	test "should not save without text" do 
		work = Work.new
		assert_not work.save, "saved the work without text"
	end

	test "should not save with just text" do
		work = Work.new(body: "Example text baby!")
		assert_not work.save
	end
end

