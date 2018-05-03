class SchedulesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_schedule, only: [:show, :update, :edit, :destroy]
  before_action :who_is_it, only: [:show, :edit, :new, :index, :update]

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
    # debugger
    if @schedule.save
      redirect_to schedules_path ,notice: "新たにスケジュールを作成しました。"
    else
      redirect_to new_schedule_path, notice: "スケジュールを作成できませんでした。"
    end
  end

  def index
    @teams = current_user.teams
    @week_name = ["日", "月", "火", "水", "木", "金", "土", "日"]
    @members = Participate.all
    @schedules = Member.where("user_id = ?", current_user.id)
  end

  def show
    team_id = Schedule.find(params[:id])
    if Member.find_by("team_id = ? and user_id = ?", team_id , current_user.id).admin == 1
      @admin = true
    else
      @admin = false
    end
    # debugger
    # @participate = Participate.where("(schedule_id = ? )", params[:id])
    @week_name = ["日", "月", "火", "水", "木", "金", "土", "日"]
    @participates = Participate.where(schedule_id: params[:id])
    @attend = Participate.where("schedule_id = ? and status = ?", params[:id], 1).count
    @absence = Participate.where("schedule_id = ? and status = ?", params[:id], 2).count
    @pend = Participate.where("schedule_id = ? and status = ?", params[:id], 0).count
    # debugger

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

  def history
      @teams = current_user.teams
      @week_name = ["日", "月", "火", "水", "木", "金", "土", "日"]
      @games = Game.page(params[:page])
      @members = Participate.where("user_id = ?", current_user.id)
  end

  private
    def schedule_params
      params.require(:schedule).permit(:title, :place, :schedule_date ,:memo, :team_id, :start_time, :end_time)
    end

    def set_schedule
      @schedule = Schedule.find(params[:id])
    end
    def who_is_it
      if user_signed_in?
        @admin_user = true if Member.where("user_id = ? and admin = ?",current_user.id, true).present?
    #     # @member = true if Member.where("user_id = ? and admin = ?",current_user.id, false).present?
    #     # @brand_new = true unless Member.where("user_id = ? and admin = ?",current_user.id, false).present?
    #     # @invited = true if Member.where("user_id = ? and status = ?",current_user.id, 0).present?
    #     # @invited_by = Member.where("user_id = ? and status = ?",current_user.id, 0)
      end
    end

end

# mamber_status
#  0:欠席
#  1:出席
#  2:保留



