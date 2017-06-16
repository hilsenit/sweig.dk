class Work < ApplicationRecord
	belongs_to :user
	has_many :saved_works, dependent: :destroy
	extend FriendlyId
	friendly_id :title, use: :slugged
	enum status: { draft: 0, published: 1}
	validates :title, :body, presence: true

	def self.search(searched_for)
		where("title ILIKE ? OR body ILIKE ?", "%#{searched_for}%", "%#{searched_for}%")
	end
end
