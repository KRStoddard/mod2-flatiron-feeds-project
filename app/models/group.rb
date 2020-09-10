class Group < ApplicationRecord
    has_many :group_members
    has_many :users, through: :group_members 
    has_many :posts
    #sorts group associations based on time created and gets rid of any assigned to deleted user
    #this helper method is used while viewing group members
    def sort_memberships
        self.group_members.sort {|membership| membership.created_at}.select{|membership| membership.user_id != User.find_by(username: "deleted_user").id}
    end


end
