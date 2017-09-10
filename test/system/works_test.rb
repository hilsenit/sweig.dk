require "application_system_test_case"

class WorksTest < ApplicationSystemTestCase
	test "visiting nyeste and check headline" do
		visit nyeste_path()
		assert_selector "h1", text: "NYESTE"
	end
end
