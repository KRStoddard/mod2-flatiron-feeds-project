class ChatsController < ApplicationController
    before_action :find_chat, only: [:show, :destroy, :edit, :update]

    def show
        flash[:chat] = @chat.id 
    end


    def new
        @chat = Chat.new
        if flash[:user]
            flash[:user] = flash[:user]
        end
    end

    def create
        @chat = Chat.create(chat_params(:name))
        if @chat.valid?
            Chatmember.create(chat_id: @chat.id, user_id: @signed_in_user.id)
            if flash[:user]
                Chatmember.create(chat_id: @chat.id, user_id: flash[:chat])
            end 
            redirect_to chat_path(@chat)
        else
            flash[:errors] = @chat.errors.full_messages
            redirect_to new_chat_path
        end
    end



    private

    def find_chat
        @chat = Chat.find(params[:id])
    end

    def chat_params(*args)
        params.require(:chat).permit(*args)
    end
end
