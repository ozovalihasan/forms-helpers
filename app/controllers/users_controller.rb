class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    @user = User.new(user_params)

    flash[:info] = if @user.save
                     ['The user is saved successfully.']
                   else
                     @user.errors.full_messages
                   end
    redirect_to new_user_path
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      flash[:info] = ['The user is edited successfully.']
      @user = User.find(params[:id]).update user_params
    else
      flash[:info] = user.errors.full_messages
    end
    redirect_to edit_user_path(user)
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
