class Chat < ApplicationRecord
    has_many :chatmembers
    has_many :users, through: :chatmembers 
    has_many :messages
end
