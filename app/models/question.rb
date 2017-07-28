class Question < ApplicationRecord
	has_many :votes, dependent: :destroy
	validates_presence_of :headline, message: "Overskriften skal udfyldes."
	validates_presence_of :text, message: "Teksten skal udfyldes."


	def self.vote_count_sort
		order(vote_count: :desc)
	end
end
