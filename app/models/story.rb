class Story < ApplicationRecord
	belongs_to :user, class_name: "User"

	default_scope {order(created_at: :desc)}
end
