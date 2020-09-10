class GroupMembersController < ApplicationController
    #creates a new relationship between a user and a group
    def create
        @group_member = GroupMember.create(user_id: @signed_in_user.id, group_id: flash[:group])
        redirect_to view_members_path(flash[:group])
    end
    #deletes relationship between a member and a group
    def destroy
        GroupMember.find_by(group_id: flash[:group], user_id: @signed_in_user.id).destroy
        redirect_to group_path(flash[:group])
    end
end
