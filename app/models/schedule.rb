class Schedule < ApplicationRecord
	belongs_to :team

	has_many :participates
	has_many :users, through: :participates
end
