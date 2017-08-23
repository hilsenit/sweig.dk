class Mark < ApplicationRecord
  has_many :markings
  has_many :works, through: :markings

  validates_uniqueness_of :title
end
