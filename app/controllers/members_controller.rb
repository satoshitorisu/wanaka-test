class MembersController < ApplicationController
  before_action :who_is_it, only: [:apply, :invite, :create, :invited, :show, :edit, :index, :new]


	def index
		
	end

  def apply
    @teams = Team.search(params[:search])
    # debugger
    # @teams = Team.search(params[:search])
    # debugger
    # @member = Member.new
    # @team = Team.search(params[:search])

    searched_flag = false
    searched_flag = params[:searched_flag]

    # debugger
    # if @team.present?
    #既に招待・参加しているユーザーをチェック
     # if Member.where("(team_id = ?) AND (user_id = ?)", @team.id, current_user.id ).present?
        # @search_result = "既に参加・申し込みしているチームです。"
        # @team = nil
        # redirect_to member_apply_path , notice: "チーム追加を申請しました。管理者による承認後、チームに参加しできます。"
    # debugger

    #検索結果がnilの場合
      # elsif  !(searched_flag.nil?)
        # @search_result = "該当するユーザーが存在しません。もう一度ご確認の上、再入力してください。"
    # エラーがない場合
    # end
  end

  def invite

    # @member = Member.new
    @user = User.search(params[:search])
    # team_id = params[:id]
    # debugger
    # searched_flag = false
    # searched_flag = params[:searched_flag]

    # if @user.present?
    # #既に招待・参加しているユーザーをチェック
    #  if Member.where("(team_id = ?) AND (user_id = ?)", team_id, @user.id ).present?
    #     @search_result = "既に参加・招待しているユーザーです。"
    #     @user = nil

    # #検索結果がnilの場合
    #   elsif  !(searched_flag.nil?)
    #     @search_result = "該当するユーザーが存在しません。もう一度ご確認の上、再入力してください。"

    # #エラーがない場合
    #   else
    #     @search_result = ""
    #   end
    # end
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

  def destroy
    # debugger
   # debugger
   @member = Member.find(params[:member_id])
   @member.destroy
   redirect_to team_path(params[:team_id])
  end

  private
  def member_params
    params.require(:member).permit(:team_id, :user_id ,:admin, :status, :greeting, :searched_flag)
  end

  def who_is_it
    if user_signed_in?
      @admin = true if Member.where("user_id = ? and admin = ?",current_user.id, true).present?
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
