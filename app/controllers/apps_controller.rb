class AppsController < ApplicationController
  before_action :set_profile, only: [:index]
  before_action :who_is_it, only: [:index]

  def index
    if user_signed_in?
      @teams = current_user.teams
      @week_name = ["日", "月", "火", "水", "木", "金", "土", "日"]
      @games = Game.page(params[:page])
      # @members = Participate.where("user_id = ?", current_user.id)
      @members = Participate.all
      # debugger
    end
  end

  def about
    
  end

  private
    def set_profile
      if user_signed_in?
        if current_user.profile_set == nil
          redirect_to edit_user_path(current_user) , notice: "機能をご利用頂くにはプロフィールの設定が必要になります。"
        end
      end
    end
    def who_is_it
      if user_signed_in?
        @admin_user = true if Member.where("user_id = ? and admin = ?",current_user.id, true).present?
        @member = true if Member.where("user_id = ? and admin = ?",current_user.id, false).present?
        @brand_new = true unless Member.where("user_id = ? and admin = ?",current_user.id, false).present?
        @invited = true if Member.where("user_id = ? and status = ?",current_user.id, 0).present?
        @invited_by = Member.where("user_id = ? and status = ?",current_user.id, 0)
      end
    end
end