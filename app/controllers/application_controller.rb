class ApplicationController < ActionController::Base
    #before_action :authorized

    def signed_in_user
        @signed_in_user = User.find_by(id: session[:signed_in_user])
    end

    def authorized
        redirect_to users_home_path unless signed_in_user 
    end
end
