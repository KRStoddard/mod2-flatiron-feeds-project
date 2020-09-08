class Post < ApplicationRecord
    has_one :user 
    has_one :group
    has_many :comments



end
