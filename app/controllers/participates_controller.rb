class ParticipatesController < ApplicationController
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
		participate = Participate.find_by(schedule_id: params[:schedule_id] , user_id: current_user.id)
		participate.status = params[:status]

		if participate.save
			redirect_to teams_path , notice: ""
		else
			redirect_to participates_path(@user), notice: ""
		end
	end

	def show
		# debugger
		# team = Schedule.find(params[:id]).team_id
		# members = Member.where(team_id: team)
		# debugger

		participates = Participate.where(schedule_id: params[:id])
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
end

# mamber_status
#  0:欠席
#  1:出席
#  2:保留



