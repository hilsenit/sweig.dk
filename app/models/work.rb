class Work < ApplicationRecord
	belongs_to :user
	extend FriendlyId
	friendly_id :title, use: :slugged
	enum status: { draft: 0, published: 1}

	def self.search(searched_for)
		where("title LIKE ? OR body LIKE ?", "%#{searched_for}%", "%#{searched_for}%")
	end
end
