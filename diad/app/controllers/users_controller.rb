class UsersController < ApplicationController

def new
end

def create
  @user = User.new(user_params)
  if @user.save
      flash[:notice] = "Account Created! Please login."
      redirect_to log_in_path
  else
      flash[:alert] = "There was a problem creating your account. Please try again."
      redirect_to :back

  end

end

private

def user_params
 params.require(:user).permit(:name, :age, :email, :password, :password_confirmation)
end

end
