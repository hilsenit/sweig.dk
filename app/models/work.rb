class Work < ApplicationRecord
	belongs_to :user
	extend FriendlyId
	friendly_id :title, use: :slugged
	enum status: { draft: 0, published: 1}
	validates :title, presence: true
	validates :body, presence: true
	def self.search(searched_for)
		where("title LIKE ? OR body LIKE ?", "%#{searched_for}%", "%#{searched_for}%")
	end
end
