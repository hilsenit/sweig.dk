class Mark < ApplicationRecord
  has_many :markings
  has_many :works, -> { where(status: 1)}, through: :markings

  validates_uniqueness_of :title


end
