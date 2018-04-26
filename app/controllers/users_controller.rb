class UsersController < ApplicationController

  def show
    @user = User.new(user_params)

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.new(user_params)
    # debugger
  end


  def confirm
    @user = User.new(user_params)
    # debugger
  end

  def complete
    user = User.find(current_user.id)
    user.profile_set = true
    user.update(user_params)
    
    # debugger
    # debugger
    # user.update( name: "やっぱり鈴木", email: "suzuki@test.co.jp" )
    # @user.update_attribute(user_params)
    # @user.update

  end

  def show
    @user = User.find(params[:id])
  end

  def create
  	@user = User.find(params[:id])
  	if @user.update(user_params)
  		redirect_to users_path , notice: "プロフィールを更新しました。"
  	else
  		redirect_to edit_user_path(@user), notice: "プロフィールを更新できませんでした。"
  	end
  end

  private
	  def user_params
	  	params.require(:user).permit(:username, :first_name, :last_name, :first_name_kana, :last_name_kana, :image, :email, :birth_day, :sex, :profile_set, :image_id)
	  end
end