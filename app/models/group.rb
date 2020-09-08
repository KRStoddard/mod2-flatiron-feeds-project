class Group < ApplicationRecord
    has_many :group_members
    has_many :users, through: :group_members 
    has_many :posts

    def sort_memberships
        self.group_members.sort {|membership| membership.created_at}
    end
end
