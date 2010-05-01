class Status < ActiveRecord::Base
  belongs_to :user, :foreign_key => "user_id"
  attr_accessor :address
end
