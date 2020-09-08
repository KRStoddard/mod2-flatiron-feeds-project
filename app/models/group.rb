class Group < ApplicationRecord
    has_many :group_members
    has_many :users, through: :group_members 
    has_many :posts

    def sort_memberships
        self.group_members.sort {|membership| membership.created_at}.select{|membership| membership.user_id != User.find_by(username: "deleted_user").id}
    end


end
