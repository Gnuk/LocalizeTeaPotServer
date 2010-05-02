class User < ActiveRecord::Base
	has_many :friendships
	has_many :friends, :through => :friendships
	has_many :statuses
	attr_accessor :last_login_at_str
	
    acts_as_authentic do |c|
    	c.validate_email_field = true # for available options see documentation in: Authlogic::ActsAsAuthentic
	end # block optional

  def to_xml(options ={})
	options[:only] = [ :login, :first_name, :last_name, :birthday, :gender ]
    #super(options, :only => [ :login, :first_name, :last_name, :birthday, :gender ] )
    super(options)
  end

end