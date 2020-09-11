class PostsController < ApplicationController
    before_action :find_post, only: [:show, :like, :edit, :update, :destroy]
    before_action :keep_group, only: [:show, :new, :edit]
    before_action :keep_post, only: [:post]
    #page to show the individual post
    def show
        flash[:post] = @post.id 
    end
    #renders form to create new post
    def new
        @post = Post.new
    end
    #creates post if valid or redirects user back to the new form
    def create
        @post = Post.create(user_id: @signed_in_user.id, likes: 0)
        @post.update(post_params(:title, :content)) 
        if @post.valid?
            if flash[:group]
                @post.update(group_id: flash[:group])
                (Group.find(@post.group_id).users.uniq - [@signed_in_user]).each do |user|
                    Notification.create(recipient: user, actor: @signed_in_user, action: "posted", notifiable: @post)
                end
            end
            if @post.group_id
                redirect_to group_path(@post.group_id)
            else
                redirect_to user_path(@signed_in_user)
            end
        else
            flash[:errors] = @post.errors.full_messages
            keep_group 
            redirect_to new_post_path
        end
    end

    #renders form to edit a post
    def edit 
    end
    #updates post
    def update
        @post.update(post_params(:title, :content))
        redirect_to post_path(@post)
    end
    #deletes post and returns you to the place the post was made
    def destroy
        @post.destroy 
        if flash[:group]
            redirect_to group_path(flash[:group])
        else
            redirect_to user_path(@signed_in_user.id)
        end
    end
    #adds one like to a post
    def like
        @post.likes += 1
        @post.save

        redirect_to post_path(@post)
    end

    private
    #assigns the post in URL to a variable
    def find_post
        @post = Post.find(params[:id])
    end
    #only allows changes to a Post based on passed in arguments
    def post_params(*args)
        params.require(:post).permit(*args)
    end

end
