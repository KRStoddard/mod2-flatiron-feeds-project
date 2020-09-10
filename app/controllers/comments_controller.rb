class CommentsController < ApplicationController
    before_action :find_comment, only: [:like, :edit, :update, :destroy]
    before_action :keep_group, only: [:show, :new, :edit]
    before_action :keep_post, only: [:edit, :new]
    #renders form for new comment
    def new
        @comment = Comment.new
    end
    #creates new comment or redirects back to the new form if comment isn't valid
    def create
        @comment = Comment.create(comment_params(:content))
        if @comment.valid?
            @comment.update(user_id: @signed_in_user.id, post_id: flash[:post], likes: 0)
            redirect_to post_path(@comment.post_id)
        else
            keep_group 
            flash[:errors] = @comment.errors.full_messages
            keep_post
            redirect_to new_comment_path
        end
    end
    #deletes comment
    def destroy
        @comment.destroy 
        redirect_to post_path(flash[:post])
    end
    #renders form to edit comment
    def edit 
    end
    #updates the comment
    def update
        @comment.update(comment_params(:content))
        redirect_to post_path(Post.find(@comment.post_id))
    end

    #adds one like to the comment
    def like
        @comment.likes += 1
        @comment.save

        redirect_to post_path(@comment.post_id)
    end

    private
    #saves comment in URL to a variable
    def find_comment
        @comment = Comment.find(params[:id])
    end
    #limits changes to comments based on passed in arguments
    def comment_params(*args)
        params.require(:comment).permit(*args)
    end
end
