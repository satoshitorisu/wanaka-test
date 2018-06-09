class MembersController < ApplicationController
  before_action :who_is_it, only: [:apply, :invite, :create, :invited, :show, :edit, :index, :new]

  def apply
    @teams = Team.search(params[:search])
    @search_result = ""

    if @teams.blank? && params[:search] != nil
      @search_result = "*入力内容が空白または、該当するチームは存在しません。チームキーをご確認の上、再度入力ください。"

    elsif @teams.present?
      if Member.find_by(team_id: @teams.find(1).id, user_id: current_user.id ).present?
          @search_result = "*既に参加・申し込みしているチームです。"
          @teams = nil
      end
    end
    # debugger
  end

  def invite

    # @member = Member.new
    @member = Member.all
    @team_id = params[:id]
    @user = User.search(params[:search])
    @search_result = ""
    # team_id = params[:id]
    # debugger
    searched_flag = false
    # searched_flag = params[:searched_flag]

    if @user.blank? && params[:search] != nil
    # #既に招待・参加しているユーザーをチェック
     @search_result = "該当するユーザーが存在しません。もう一度ご確認の上、再入力してください。"
    #  if Member.where("(team_id = ?) AND (user_id = ?)", team_id, @user.id ).present?
    #     @search_result = "既に参加・招待しているユーザーです。"
    #     @user = nil

    # #検索結果がnilの場合
      # elsif  @user.present?
        # if Member.find_by(team_id: params[:id], user_id: @user.find(1).id ).present?


    # #エラーがない場合
    #   else
    #     @search_result = ""
      # end
    end
  end

  def create
  	@member = Member.new(member_params)
  	if @member.save
  		redirect_to teams_path , notice: "メンバーを更新しました。"
  	else
  		redirect_to edit_team_path(@user), notice: "メンバーを更新できませんでした。"
  	end
  end


  def invited
    @members =  Member.where("user_id = ? and status = ?",current_user.id, 0)

  end

  def update
    member = Member.find(params[:member_id])
    member.status = params[:status]
    member.greeting = ""
    member.admin = params[:admin]
    # debugger
    member.save
    redirect_to team_path(params[:team_id])
  end


  def approve
    member = Member.find(params[:member_id])
    # debugger
    # member.status = params[:status]
    # member.greeting = ""
    # member.admin = params[:admin]
    # debugger
    member.update(status: 2)
    redirect_to team_path(params[:team_id])
  end

  def destroy
   @member = Member.find(params[:id])
   @member.destroy
   redirect_to team_path
  end

  private
  def member_params
    params.require(:member).permit(:team_id, :user_id ,:admin, :status, :greeting, :searched_flag)
  end

  def who_is_it
    if user_signed_in?
      @admin_user = true if Member.where("user_id = ? and admin = ?",current_user.id, true).present?
      @member = true if Member.where("user_id = ? and admin = ?",current_user.id, false).present?
      # @brand_new = true unless Member.where("user_id = ? and admin = ?",current_user.id, false).present?
      # @invited = true if Member.where("user_id = ? and status = ?",current_user.id, 0).present?
      # @invited_by = Member.where("user_id = ? and status = ?",current_user.id, 0)
    end
  end
end

# mamber_status
#  0:invite
#  1:apply
#  2:join
