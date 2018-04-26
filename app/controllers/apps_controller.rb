class AppsController < ApplicationController
  before_action :set_profile, only: [:index]

  def index
  	if user_signed_in?
  		@admin = true if Member.where("user_id = ? and admin = ?",current_user.id, true).present?
      @member = true if Member.where("user_id = ? and admin = ?",current_user.id, false).present?
  		@brand_new = true unless Member.where("user_id = ? and admin = ?",current_user.id, false).present?
      @invited = true if Member.where("user_id = ? and status = ?",current_user.id, 0).present?
  	  @invited_by = Member.where("user_id = ? and status = ?",current_user.id, 0)
    end
    # debugger
  end

  private
	  def set_profile
	  	if user_signed_in?
		  	if current_user.profile_set == nil
		  		redirect_to edit_user_path(current_user) , notice: "機能をご利用頂くにはプロフィールの設定が必要になります。"
		  	end
	  	end
	  end
end
