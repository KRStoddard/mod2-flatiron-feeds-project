class PostsController < ApplicationController
   
    def new
        @post = Post.new
    end

    def create
        @post = Post.create(post_params :title, :content) 
        if @post.valid?
            @post.update(user_id: @signed_in_user.id)
            if @post.group_id
                redirect_to group_path(@post.group)
            else
                redirect_to user_path(@signed_in_user)
            end
        else
            flash[:errors] = @post.errors.full_messages
            redirect_to new_post_path
        end
    end

end
