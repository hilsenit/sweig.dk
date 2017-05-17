class User < ApplicationRecord
	has_many :works
	accepts_nested_attributes_for :works
	extend FriendlyId
	friendly_id :name, use: :slugged
end
