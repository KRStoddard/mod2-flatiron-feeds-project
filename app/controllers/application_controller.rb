class ApplicationController < ActionController::Base
    before_action :signed_in_user, :authorized 

    def signed_in_user
        @signed_in_user = User.find_by(id: session[:signed_in_user_id])

    end

    def authorized
        redirect_to users_home_path unless signed_in_user 
    end
end
