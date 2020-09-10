class User < ApplicationRecord
    has_many :posts
    has_many :comments
    has_many :group_members
    has_many :groups, through: :group_members 
    belongs_to :cohort
    has_many :chatmembers
    has_many :chats, through: :chatmembers 
    has_many :messages
    has_many :replies
    has_secure_password
    has_one_attached :image 
    #checks to make sure username is unique and that the user belongs to a cohort
    validates :username, uniqueness: :true
    validates :cohort_id, presence: true

    #helper method to list user's full name
    def full_name
        "#{self.first_name} #{self.last_name}"
    end
    #lists only posts that aren't made to a group
    def profile_posts
        self.posts.each {|post| post.group_id == nil}
    end
end
