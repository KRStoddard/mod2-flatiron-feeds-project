class MessagesController < ApplicationController
    before_action :keep_chat, only: [:new, :create]
    before_action :find_message, only: [:edit, :update, :destroy]

    def new
        @message = Message.new 
    end

    def create 
        @message = Message.create(chat_id: flash[:chat], user_id: @signed_in_user.id)
        @message.update(message_params(:content))
        if @message.valid?
            (Chat.find(@message.chat_id).users.uniq - [@signed_in_user]).each do |user|
                Notification.create(recipient: user, actor: @signed_in_user, action: "posted", notifiable: @message)
            end
            redirect_to chat_path(flash[:chat])
        else
            keep_chat
            flash[:errors] = @message.errors.full_messages
            redirect_to new_message_path
        end
    end 

    def edit
    end

    def update
        @message.update(message_params(:content))
        redirect_to chat_path(@message.chat)
    end

    def destroy
        @message.destroy 
        redirect_to chat_path(flash[:chat])
    end 

    private

    def find_message
        @message = Message.find(params[:id])
    end

    def message_params(*args)
        params.require(:message).permit(*args)
    end
        
end
