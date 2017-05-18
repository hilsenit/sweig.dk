class User < ApplicationRecord
	has_many :works
	extend FriendlyId
	friendly_id :name, use: :slugged
end
