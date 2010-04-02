class User < ActiveRecord::Base
	has_many :friendships
	has_many :friends, :through => :friendships
	has_many :statuses
	
    acts_as_authentic do |c|
    	c.validate_email_field = true # for available options see documentation in: Authlogic::ActsAsAuthentic
	end # block optional
end