class SchedulesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_schedule, only: [:show, :update, :edit, :destroy]

  def new
    @schedule = Schedule.new
    @multi_teams = nil

    if Member.where("(user_id = ?) AND (admin = ?)",  current_user.id , true).count == 1
      @admin_team = Member.find_by("(user_id = ?) AND (admin = ?)",  current_user.id , true)
      @multi_teams = false
    else
      @admin_team = Member.where("(user_id = ?) AND (admin = ?)",  current_user.id , true)
      @multi_teams = true
    end
  end

  def create
    @schedule = Schedule.new(schedule_params)

    # debugger
    if @schedule.save
      redirect_to schedules_path ,notice: "新たにスケジュールを作成しました。"
    else
      redirect_to new_schedule_path, notice: "スケジュールを作成できませんでした。"
    end
  end

  def index
    @teams = current_user.teams

  end

  def update
    if @schedule.update(schedule_params)
      redirect_to schedules_path , notice: "スケジュールを更新しました。"
    else
      redirect_to edit_schedule_path(@schedule), notice: "スケジュールを更新できませんでした。"
    end
  end

  def destroy
     @schedule.destroy
     redirect_to schedules_path
  end

  private
    def schedule_params
      params.require(:schedule).permit(:title, :place, :date_time ,:memo, :team_id, :start_time, :end_time)
    end

    def set_schedule
      @schedule = Schedule.find(params[:id])
    end
end
