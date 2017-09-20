class Marking < ApplicationRecord
	belongs_to :work
	belongs_to :mark
	validate :max_5_marks
	def max_5_marks
		errors.add(:marks, "Max 5 mærker per værk") if self.work.marks.size > 4
	end
end
