class User < ApplicationRecord
    has_many :posts
    has_many :comments
    has_many :group_members
    has_many :groups, through: :group_members 
    belongs_to :cohort

    def full_name
        "#{self.first_name} #{self.last_name}"
    end

    def profile_posts
        self.posts.select {|post| post.group_id == nil}
    end
end
