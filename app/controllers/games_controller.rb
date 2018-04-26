class GamesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game, only: [:show, :update, :edit, :destroy]

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
    # @game.team_id = 1
    #要更新
    # debugger



    if @game.save
      redirect_to games_path, notice: "申し込み内容を作成しました。"
    else
      redirect_to new_game_path, notice: "申し込み内容を作成できませんでした。"
    end
  end

  def index
    @games = Game.all
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
      params.require(:game).permit(:title, :place, :price, :date_time, :memo, :start_time, :end_time, :team_id)
    end

    def set_game
      @game = Game.find(params[:id])
    end
end
