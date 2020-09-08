class Post < ApplicationRecord
    belongs_to :user 
    belongs_to :group
    has_many :comments

    validates :user, presence: true
end
