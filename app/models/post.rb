class Post < ApplicationRecord
    belongs_to :user 
    has_one :group
    has_many :comments

        validates :title, presence: true
end
