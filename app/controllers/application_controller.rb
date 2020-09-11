class ApplicationController < ActionController::Base
    before_action :signed_in_user, :authorized 
    
    
    
    #finds the user assigned to session
    def signed_in_user
        @signed_in_user = User.find_by(id: session[:signed_in_user_id])
    end
    #keeps people from viewing pages unless they are signed in
    def authorized
        redirect_to users_home_path unless signed_in_user 
    end
    #allows access to the last group visited across multiple pages
    def keep_group
        if flash[:group]
            flash[:group] = flash[:group]
        end
    end
    #allows access to the last group visited across multiple pages
    def keep_post
        if flash[:post]
            flash[:post] = flash[:post]
        end
    end
    
    def keep_comment
        if flash[:comment]
            flash[:comment] = flash[:comment]
        end
    end

    def keep_chat
        if flash[:chat]
            flash[:chat] = flash[:chat]
        end
    end

end
