class SessionsController < ApplicationController
    #skip_before_action :authorized, only: [:new, :sign_in]

    def new
    end

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

    def logout
        session.delete(:signed_in_user_id)
        redirect_to users_home_path
    end

end
