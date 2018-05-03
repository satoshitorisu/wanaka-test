class Team < ApplicationRecord
	has_many :users, through: :members
	has_many :members
  accepts_nested_attributes_for :members

  has_many :schedules, dependent: :destroy
  has_many :games
  
  attachment :image

  validates :name, presence: true
  validates :organization, presence: true
  validates :active_place, presence: true
  validates :description, presence: true
  validates :level, presence: true
  validates :established_year, presence: true
  # validates :established_year, length: { is: 4 }
  # validates :established_year, numericality: true, :only_integer

  validates :image, presence: true




  def self.search(search) #self.でクラスメソッドとしている
    if search # Controllerから渡されたパラメータが!= nilの場合は、titleカラムを部分一致検索
      Team.where(team_key: "#{search}")
      # Team.where(['id LIKE ?', "%#{search}%"])
    else
      # Team.all #全て表示。
    end
  end



end

# has_many :groups, through: :group_users
# has_many :group_users
# t.string "name"
# t.string "organization"
# t.string "active_place"
# t.string "level"
# t.string "description"
# t.string "image"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.string "team_key"
# t.string "leader"