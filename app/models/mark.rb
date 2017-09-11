class Mark < ApplicationRecord
	before_save { |mark| mark.title.upcase! unless mark.title.nil? }

	extend FriendlyId
	friendly_id :title, use: :slugged
	
  has_many :markings
  has_many :works, -> { where(status: 1)}, through: :markings

  validates_uniqueness_of :title


end
