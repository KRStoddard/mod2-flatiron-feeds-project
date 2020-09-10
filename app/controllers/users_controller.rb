class UsersController < ApplicationController
    before_action :find_user, only: [:show, :destroy]
    before_action :going_home, only: [:home]
    skip_before_action :authorized, only: [:new, :create, :home]
    #profile page for user
    def show
        @user = User.find(params[:id])
    end
    #renders form to create a new user
    def new
        @user = User.new
        @cohorts = Cohort.all
    end
    #creates a new user and, if valid, assigns them to their cohort's group
    #if not valid, redirects them back to the path
    def create 
        @user = User.create(user_params(:username, :first_name, :last_name, :password, :birthday, :cohort_id, :image))
        if @user.valid?
            session[:signed_in_user_id] = @user.id
            GroupMember.create(user_id: @user.id, group_id: Group.find_by(code: @user.cohort.code).id)
            flash[:success] = "Welcome!"
            redirect_to user_path(@user)
        else
            flash[:errors] = @user.errors.full_messages
            redirect_to new_user_path(@user)
        end
    end
    #renders home page
    def home  
    end
    #destroys relationship with every group
    #changes all created posts and comments to belonging to a deleted_user
    #deletes user
    def destroy
        @user.group_members.each {|group_membership| group_membership.destroy}
        @user.posts.each {|post| post.update(user_id: User.find_by(username: "deleted_user").id)}
        @user.comments.each {|comment| comment.update(user_id: User.find_by(username: "deleted_user").id)}
        @user.destroy 
        redirect_to users_home_path
    end

    private
    #if someone reaches the homepage without signing out, will auto-sign them out
    def going_home
        if @signed_in_user
            session.delete(:signed_in_user_id)
        end
    end
    #assigns user from URL to a variable
    def find_user
        @user = User.find(params[:id])
    end
    #only allows changes to User based on passed in arguments
    def user_params(*args)
        params.require(:user).permit(*args)
    end


    
end
