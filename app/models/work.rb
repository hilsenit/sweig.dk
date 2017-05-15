class Work < ApplicationRecord
	belongs_to :user

	def self.search(searched_for)
		where("title LIKE ? OR body LIKE ?", "%#{searched_for}%", "%#{searched_for}%")
	end
end
