class UsersController < ApplicationController
    before_action :find_user, only: [:show, :destroy]
    skip_before_action :authorized, only: [:new, :create, :home]

    def show
        @user = User.find(params[:id])
    end

    def new
        @user = User.new
        @cohorts = Cohort.all
    end

    def create 
        @user = User.create(user_params(:username, :first_name, :last_name, :password, :birthday, :cohort_id))
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

    def home
    end

    def destroy
        @user.group_members.each {|group_membership| group_membership.destroy}
        @user.posts.each {|post| post.update(user_id: User.find_by(username: "deleted_user").id)}
        @user.comments.each {|comment| comment.update(user_id: User.find_by(username: "deleted_user").id)}
        @user.destroy 
        redirect_to users_home_path
    end

    private


    def find_user
        @user = User.find(params[:id])
    end

    def user_params(*args)
        params.require(:user).permit(*args)
    end

    
end
