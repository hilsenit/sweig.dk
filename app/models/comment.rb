class Comment < ApplicationRecord
	belongs_to :question
	belongs_to :user
	validates :text,
		presence:  true,
		length:    {maximum:  300}
	
	
end
