class Game < ApplicationRecord
	geocoded_by :place
	after_validation :geocode, :if => :place_changed?

	belongs_to :team
end
