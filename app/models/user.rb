class User < ApplicationRecord
	extend FriendlyId
	friendly_id :username, use: :slugged
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :confirmable, :registerable,
	:recoverable, :rememberable, :trackable, :validatable

	#Relationships
	has_many :works, dependent: :destroy
	accepts_nested_attributes_for :works
	has_many :comments, dependent: :destroy
	has_many :saved_works, dependent: :destroy
	has_many :votes, dependent: :destroy
	has_many :stories, dependent: :destroy
	#foelger.rb har followed_id og follower_id i sig (aktivt og passivt)
	has_many :active_relationships, class_name: "Foelger", 
									foreign_key: "follower_id", 
									dependent: :destroy

	has_many :passive_relationships, class_name: "Foelger",
									foreign_key: "followed_id",
									dependent: :destroy

	has_many :following, through: :active_relationships, source: :followed #
	has_many :followers, through: :passive_relationships, source: :follower

	#Validation
	validates_presence_of :username, :email, :password
	validates_uniqueness_of :email
	validates :username, uniqueness: {case_sensitive: false} 


	def biblo
			following_ids = self.following_ids
			Work.where(status: 1).select{|w| following_ids.include? w.user_id } 
	end

	def following? other_user
		following.include?(other_user)
	end

	def follow other_user
		following << other_user
	end

	def unfollow other_user
		following.delete(other_user)
	end

	def followers? other_user
		followers.include?(other_user)
		
	end
	def self.search(searched_for)
		where("username ILIKE ?", "%#{searched_for}%")
	end

	def self.sort_users
		order(created_at: :desc).limit(8)
	end



end
