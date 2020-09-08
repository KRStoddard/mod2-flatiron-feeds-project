class PostsController < ApplicationController
    before_action :find_post, only: [:show]
   
    def show
        flash[:post] = @post.id 
    end
    
    def new
        @post = Post.new
        if flash[:group]
            flash[:group]
        end
    end

    def create
        @post = Post.create(post_params :title, :content) 
        if @post.valid?
            @post.update(user_id: @signed_in_user.id)
            if flash[:group]
                @post.update(group_id: flash[:group])
            end
            if @post.group_id
                redirect_to group_path(@post.group)
            else
                redirect_to user_path(@signed_in_user)
            end
        else
            flash[:errors] = @post.errors.full_messages
            if flash[:group]
                flash[:group]
            end
            redirect_to new_post_path
        end
    end

    private

    def find_post
        @post = Post.find(params[:id])
    end

end
