class SavedWork < ApplicationRecord

	belongs_to :user
	has_one :work
end
