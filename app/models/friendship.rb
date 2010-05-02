class Friendship < ActiveRecord::Base
  belongs_to :user, :foreign_key => "user_id"
  belongs_to :friend, :class_name => "User", :foreign_key => "friend_id"
  validates_uniqueness_of :user_id, :scope => [:friend_id]
  
  attr_accessor :friend_login
  attr_accessor :status
  
  def to_xmlh(options ={})
	proc = Proc.new { |options| options[:builder].tag!('ghi', 'jkl') }
	options[:only] = [ :id, :user_id, :friend_id, :see_position]
	options[:procs] = [ proc]
	#options[:include] = [ :friend_id]
    super(options)
  end

    def to_xml(options = {})
      options[:indent] ||= 2
      xml = options[:builder] ||= Builder::XmlMarkup.new(:indent => options[:indent])
      xml.instruct! unless options[:skip_instruct]
      xml.see_position(see_position)
	#  xml.user do
		@friend = User.find(friend_id);
		@friend.to_xml(options)
     # end
    end

    
 def to_json(options ={})
	options[:only] = [ :id, :user_id, :friend_id, :see_position]
    super(options)
 end
  
end
