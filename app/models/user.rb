class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	has_many :members
	has_many :teams, through: :members
  has_many :games

  has_many :participates
  has_many :schedules, through: :participates

  attachment :image

  validates :username, uniqueness: true

  # validates :username, uniqueness: true
 # def self.search(search)
    # if search
      # User.find_by("(email = ?) OR (username = ?)", search, search)
    # end
  # end

  def self.search(search) #self.でクラスメソッドとしている
    if search # Controllerから渡されたパラメータが!= nilの場合は、titleカラムを部分一致検索
      User.where("(email = ?) OR (username = ?)", search, search)
      # Team.where(['id LIKE ?', "%#{search}%"])
    else
      # Team.all #全て表示。
    end
  end
end

