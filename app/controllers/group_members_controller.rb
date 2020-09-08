class GroupMembersController < ApplicationController

    def create
        @group_member = GroupMember.create(user_id: @signed_in_user.id, group_id: flash[:group])
        redirect_to view_members_path(flash[:group])
    end
end
