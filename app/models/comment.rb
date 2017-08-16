class Comment < ApplicationRecord
	MAXIMUM_COMMENTS_PR_USER = 100
	belongs_to :question
	belongs_to :user
	validates :text,
		presence:  true,
		length:    {maximum:  300}
	

	default_scope { order(created_at: :asc) } 

	validate on: :create do 
		if self.user.comments.length > 100 
			errors.add(:comment, "Det er indtil videre kun muligt at have 100 kommentarer på Sweig.")
		end
	end
end
