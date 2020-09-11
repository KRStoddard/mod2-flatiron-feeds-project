class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :post 
    has_many :replies
    has_many :users, through: :replies

end
