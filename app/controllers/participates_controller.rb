class ParticipatesController < ApplicationController
before_action :who_is_it, only: [:index, :update, :show]

  def index
    @teams = current_user.teams
  end

	def create
		participate = Participate.new(user_id: current_user.id)
		participate.status = params[:status]
		participate.schedule_id = params[:schedule_id]

		if participate.save
			redirect_to teams_path , notice: ""
		else
			redirect_to participates_path(@user), notice: ""
		end
	end

	def update
		if Participate.find_by(schedule_id: params[:schedule_id] , user_id: current_user.id).present?
			participate = Participate.find_by(schedule_id: params[:schedule_id] , user_id: current_user.id)
			# debugger
			participate.status = params[:status]
			if participate.save
				redirect_to root_path , notice: ""
			else
				redirect_to participates_path(@user), notice: ""
			end
		else
			participate = Participate.new(user_id: current_user.id)
			participate.status = params[:status]
			participate.schedule_id = params[:schedule_id]

			if participate.save
				redirect_to root_path , notice: ""
			else
				redirect_to participates_path(@user), notice: ""
			end
		end


	end

	def show
		# debugger
		# team = Schedule.find(params[:id]).team_id
		# members = Member.where(team_id: team)
		# debugger

		@participates = Participate.where(schedule_id: params[:id])
		# @participate_hash = {}
		# @participate_hash.store{ "#{participate.user_id}":  "#{participate.status}" }
		# @participate_hash.store{ :"#{participate.user_id}"=>  participate.status }

		@members = Participate.where(schedule_id: params[:id])
		@schedule = Schedule.find(params[:id])
		# debugger
	end

	def destroy
	end

  private
  def participate_params
    params.require(:participate).permit(:schedule_id, :user_id ,:status)
  end
    def who_is_it
      if user_signed_in?
        @admin_user = true if Member.where("user_id = ? and admin = ?",current_user.id, true).present?
      end
    end
end

# mamber_status
#  0:欠席
#  1:出席
#  2:保留


