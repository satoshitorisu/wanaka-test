class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: [:index, :show, :update, :edit, :destroy, :new]
  before_action :set_team, only: [:show, :update, :edit, :destroy]
  before_action :who_is_it, only: [:show, :edit, :index, :new]

  # @@error_msg = ""
	def new
		@team = Team.new
		@team.members.build
		
		# established_year = []
		# Date.today.year


		# for	num in 1 .. 80 do
		# 	established_year.push[established_year + 1 - num]
		# end


		# debugger
	end

	def create
		team = Team.new(team_params)
		team.established_year = team_params["established_year(1i)"]
		# unless team.established_year.to_s =~ /^[ -~｡-ﾟ]*$/
		# 	if team.established_year =~ /^[0-9]+$/
		# 		if team.established_year.length == 4
		# 			debugger
		# 		end
		# 	end
		# end
		# @@error_msg = "aaa"
		# debugger



		team.team_key = SecureRandom.hex(5)
		team.leader = current_user.id
		# debugger
		if team.save
			member = team.members.new
			member.team_id = team.id
			member.user_id = current_user.id
			member.admin = true
			member.status = 2
			member.save
			redirect_to team_path(team.id)
		else
			redirect_to new_team_path
		end
	end

	def index
		@members = Member.where(user_id: current_user.id)
		@applied = Member.where(status: 1)
	    @week_name = ["日", "月", "火", "水", "木", "金", "土", "日"]



		# debugger
	end

	def edit
		@members = Member.where(team_id: params[:id])

	end

	def show
		@members = Member.where(team_id: params[:id])

	end

	def update
		if @team.update(team_params)
			redirect_to teams_path , notice: "プロフィールを更新しました。"
		else
			redirect_to edit_team_path(@user), notice: "プロフィールを更新できませんでした。"
		end
	end

  def destroy
  	# debugger
     
	 if @team.destroy
	 	redirect_to teams_path
	 else
	 	redirect_to edit_team_path(@team)
	 end

  end

  private
	  def team_params
	  	params.require(:team).permit(:name, :organization, :active_place ,:level, :description, :image, :team_key, :leader, :established_year)
	  end

	  def set_team
	  	@team = Team.find(params[:id])
	  end
	  def set_profile
	  	if current_user.profile_set == nil
	  		redirect_to edit_user_path(current_user) , notice: "機能をご利用頂くにはプロフィールの設定が必要になります。"
	  	end
	  end
      def who_is_it
	      if user_signed_in?
	        @admin_user = true if Member.where("user_id = ? and admin = ?",current_user.id, true).present?
	        @member = true if Member.where("user_id = ? and admin = ?",current_user.id, false).present?
	        # @brand_new = true unless Member.where("user_id = ? and admin = ?",current_user.id, false).present?
	        @invited = true if Member.where("user_id = ? and status = ?",current_user.id, 0).present?
	        # @invited_by = Member.where("user_id = ? and status = ?",current_user.id, 0)
	      end
	    end
end
