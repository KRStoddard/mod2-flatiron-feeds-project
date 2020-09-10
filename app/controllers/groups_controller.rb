class GroupsController < ApplicationController
    before_action :find_group, only: [:show, :view_member]
    #A page to list and link to all groups
    def index
        @groups = Group.all
    end
    #Page for individual group
    def show
        flash[:group] = @group.id
        @comment = Comment.new 
    end
    #page to list all group members
    def view_members
        @group = Group.find(params[:id])
    end
    #creates a new group and assigns the creator as the first member
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
    #renders form to create a new group
    def new 
        @group = Group.new
    end

    private
    #assigns the group from the URL to a variable
    def find_group
        @group = Group.find(params[:id])
    end
    #only allows changes to a group if it matches the passed in arguments
    def group_params(*args)
        params.require(:group).permit(*args)
    end
end
