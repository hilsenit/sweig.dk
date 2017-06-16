class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	has_many :works
	has_many :saved_works
	accepts_nested_attributes_for :works
	validates :username, :email, presence: true

	extend FriendlyId
	friendly_id :username, use: :slugged
	
	def self.search(searched_for)
		where("username ILIKE ?", "%#{searched_for}%")
	end

	def self.sort_users
		order(created_at: :desc).limit(5)
	end
end
