class Friendship < ActiveRecord::Base
  belongs_to :user, :foreign_key => "user_id"
  belongs_to :friend, :class_name => "User", :foreign_key => "friend_id"
  validates_uniqueness_of :user_id, :scope => [:friend_id]
  
  attr_accessor :friend_login
  attr_accessor :status
end
