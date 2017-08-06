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
  has_many :saved_works, dependent: :destroy
  has_many :votes #only one for each question

  #Validation
  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true


  def self.search(searched_for)
  	where("username ILIKE ?", "%#{searched_for}%")
  end

  def self.sort_users
  	order(created_at: :desc).limit(8)
  end
end
