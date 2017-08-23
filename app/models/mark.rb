class Mark < ApplicationRecord
  belongs_to :work
  has_many :works
end
