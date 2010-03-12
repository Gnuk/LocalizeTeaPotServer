 class User < ActiveRecord::Base
    acts_as_authentic do |c|
      c.validate_email_field = true # for available options see documentation in: Authlogic::ActsAsAuthentic
    end # block optional
  end