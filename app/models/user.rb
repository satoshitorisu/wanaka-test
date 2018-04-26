class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	has_many :members
	has_many :teams, through: :members

  has_many :participates
  has_many :schedules, through: :participates

  attachment :image

  validates :username, uniqueness: true

  # validates :username, uniqueness: true
 def self.search(search)
    if search
      User.find_by("(email = ?) OR (username = ?)", search, search)
    end
  end
end

