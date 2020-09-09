class PostsController < ApplicationController
    before_action :find_post, only: [:show, :like, :edit, :update, :destroy]

   
    def show
        flash[:post] = @post.id 
        if flash[:group]
            flash[:group] = flash[:group]
        end
    end
    
    def new
        @post = Post.new
        if flash[:group]
            flash[:group] = flash[:group]
        end
    end

    def create
        @post = Post.create(post_params(:title, :content)) 
        if @post.valid?
            @post.update(user_id: @signed_in_user.id, likes: 0)
            if flash[:group]
                @post.update(group_id: flash[:group])
            end
            if @post.group_id
                redirect_to group_path(@post.group_id)
            else
                redirect_to user_path(@signed_in_user)
            end
        else
            flash[:errors] = @post.errors.full_messages
            if flash[:group]
                flash[:group] = flash[:group]
            end
            redirect_to new_post_path
        end
    end


    def edit 
    end

    def update
        @post.update(post_params(:title, :content))
        redirect_to post_path(@post)
    end

    def destroy
        @post.destroy 
        redirect_to user_path(@signed_in_user.id)
    end

    def like
        @post.likes += 1
        @post.save

        redirect_to post_path(@post)
    end

    private

    def find_post
        @post = Post.find(params[:id])
    end

    def post_params(*args)
        params.require(:post).permit(*args)
    end

end
