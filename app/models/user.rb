class User < ApplicationRecord
	has_many :works
	extend FriendlyId
	friendly_id :name, use: :slugged
	accepts_nested_attributes_for :works
	validates :name, :email, presence: true
end
