class Work < ApplicationRecord
	belongs_to :user

	def self.search(searched_for)
		where("name LIKE ?", "%#{searched_for}%")
	end
end
