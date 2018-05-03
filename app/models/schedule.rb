class Schedule < ApplicationRecord
	geocoded_by :place
	after_validation :geocode, :if => :place_changed?
	
	belongs_to :team

	has_many :participates
	has_many :users, through: :participates

end
