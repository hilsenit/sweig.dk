class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	has_many :works
	has_many :saved_works
	extend FriendlyId
	friendly_id :name, use: :slugged
	accepts_nested_attributes_for :works
	validates :name, :email, presence: true


	def self.sort_users
		order(created_at: :desc).limit(5)
	end
end
