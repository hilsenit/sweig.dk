class Work < ApplicationRecord
	belongs_to :user
	has_many :saved_works, dependent: :destroy
	extend FriendlyId
	friendly_id :title, use: :slugged
	enum status: { draft: 0, published: 1}
	validates :title, presence: { message: "Overskrift mangler"}
	validates :body, presence: { message: "Tekst mangler"}

	def self.search(searched_for)
		where("title ILIKE ? OR body ILIKE ?", "%#{searched_for}%", "%#{searched_for}%")
	end

	def self.published_works
		where(status: 1)
	end
end
