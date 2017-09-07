class Work < ApplicationRecord
	after_destroy { |work| Story.where(work_friendly_id: work.slug).destroy_all } # Destroys the work stories
	before_update { :all_tags_in_s_size }
	extend FriendlyId
	friendly_id :title, use: :slugged
	enum status: { draft: 0, published: 1}

	belongs_to :user

	has_many :saved_works, dependent: :destroy

	has_many :markings
	has_many :marks, through: :markings


	validates :title, presence: { message: "Overskrift mangler"}
	validates :body, presence: { message: "Tekst mangler"}

	validate :all_tags_in_s_size

	def all_tags_in_s_size
		tag_array = self.all_tags_in_s.split(",")
		errors.add(:tags, "Max 5 mærker pr. værk") if tag_array.size > 5 
		errors.add(:tags, "Mærker kan max være 30 tegn") if tag_array.any? {|t| t.size > 30}
	end

	def self.search(searched_for)
		where("title ILIKE ? OR body ILIKE ? OR all_tags_in_s ILIKE ?", "%#{searched_for}%", "%#{searched_for}%", "%#{searched_for}%")
	end

	def self.published_works
		where(status: 1)
	end
end
