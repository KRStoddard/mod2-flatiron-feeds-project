class SessionsController < ApplicationController
    skip_before_action :authorized, only: [:new, :login]
    #renders form for new login
    def new
    end
    #logs user in if username/password correct and assigns it to a session
    #uses encrypted password
    def login
        @user = User.find_by(username: params[:session][:username])
        if @user && @user.authenticate(params[:session][:password])  
            flash[:success] = "Welcome!"
            session[:signed_in_user_id] = @user.id
            redirect_to user_path(@user)
        else
            flash[:error] = "Username or Password Incorrect"
            redirect_to new_login_path
        end
    end
    #logs user out and deletes the session
    def logout
        if @signed_in_user
            session.delete(:signed_in_user_id)
        end
        redirect_to users_home_path
    end

end
