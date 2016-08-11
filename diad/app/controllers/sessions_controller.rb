class SessionsController < ApplicationController

def new
end

def create

   @user = User.authenticate(params[:email], params[:password])
 if @user
   #let the user know they've been logged in with a flash message
   flash[:notice] = "Logged in as #{@user.name} "
   #THIS IS THE MOST IMPORTANT PART. Actually log the user in by storing their ID in the session hash with the [:user_id] key!
   session[:user_id] = @user.id
  #then redirect them to the homepage
  redirect_to diad_products_path 
 else
  #whoops, either the user wasn't in the database or their password is incorrect, so let them know, then redirect them back to the log in page
  flash[:alert] = "Invalid Username or Password."
  redirect_to log_in_path
 end
end

def destroy
  session[:user_id] = nil
#  flash[:notice] = "Logged out."
  redirect_to root_path
end

end
