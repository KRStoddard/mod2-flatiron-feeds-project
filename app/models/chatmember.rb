class Chatmember < ApplicationRecord
    belongs_to :user
    belongs_to :chat 

    validates :user, uniqueness: {scope: :chat, message: "should only join chat once"}
end
