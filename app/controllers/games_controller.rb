class GamesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game, only: [:show, :update, :edit, :destroy]
  before_action :who_is_it, only: [:new, :create, :index, :uploaded, :update]
  before_action :admin_only_action, only: [:new, :create, :index, :uploaded, :update]

  def new
    @game = Game.new
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
    @game = Game.new(game_params)
    @game.status = 1

    if @game.save
      redirect_to games_path, notice: "申し込み内容を作成しました。"
    else
      redirect_to new_game_path, notice: "申し込み内容を作成できませんでした。"
    end
  end

  def index
    # @games = Game.where.not(user_id: current_user.id).page(params[:page]).per(11)
    @games = Game.where(["date_time < ? and user_id != ?", Date.today, current_user.id]).page(params[:page]).per(11)
    # paginates_per 5
    # debugger
  end

  def uploaded
    @game_uploaded = Game.where(user_id: current_user.id).page(params[:page]).per(11)
    # debugger
  end

  def update
    if @game.update(game_params)
      redirect_to games_path , notice: "申し込み内容を更新しました。"
    else
      redirect_to edit_game_path(@user), notice: "申し込み内容を更新できませんでした。"
    end
  end

  def destroy
    @game.destroy
    redirect_to games_path
  end

  private
    def game_params
      params.require(:game).permit(:title, :place, :price, :date_time, :memo, :start_time, :end_time, :team_id, :user_id)
    end

    def set_game
      @game = Game.find(params[:id])
    end
    def who_is_it
      if user_signed_in?
        @admin_user = true if Member.where("user_id = ? and admin = ?",current_user.id, true).present?
      end
    end
    def admin_only_action
      unless Member.where("user_id = ? and admin = ?",current_user.id, true).present?
        redirect_to root_path
      end
    end


end


# status
# non-active:0
# open:1
# matched:








