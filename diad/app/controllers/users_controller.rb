class UsersController < ApplicationController

def new
end

def create
  @user = User.new(user_params)
  if @user.save
      flash[:alert] = "Account Created! Please login."
      ReceiptMailer.welcome_email(@user).deliver_now
      redirect_to log_in_path
  else
      flash[:alert] = "There was a problem creating your account. Please fill out entire form."
      redirect_to :back

  end

end

private

def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
end

end
