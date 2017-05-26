class SavedWork < ApplicationRecord
	belongs_to :user
	has_many :works
end
