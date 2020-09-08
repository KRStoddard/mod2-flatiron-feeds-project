class GroupsController < ApplicationController
    before_action :find_group, only: [:show, :view_member]

    def index
        @groups = Group.all
    end

    def show
        flash[:group] = @group.id
    end

    def view_members
        @group = Group.find(params[:id])
    end

    def create
        @group = Group.create(group_params(:name, :description))
        if @group.valid?
            GroupMember.create(group_id: @group.id, user_id: @signed_in_user.id)
            redirect_to group_path(@group)
        else
            flash[:errors] = @group.errors.full_messages
            redirect_to new_group_path
        end
    end

    def new 
        @group = Group.new
    end

    private

    def find_group
        @group = Group.find(params[:id])
    end

    def group_params(*args)
        params.require(:group).permit(*args)
    end
end
