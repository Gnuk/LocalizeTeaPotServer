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
  
  def to_friendships_xml
	
#<gpx version="1.1" creator="LocalizeTeaPot server" xmlns="http://www.topografix.com/GPX/1/1"
#  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
#  xsi:schemaLocation="http://www.topografix.com/GPX/1/1 http://www.topografix.com/GPX/1/1/gpx.xsd">
#  <wpt lat="52.2015094" lon="5.13285130000001">
#    <name>Caroline</name>
#  </wpt>
#  <wpt lat="52.2069108" lon="5.11004300000001">
#    <name>Claire</name>
#  </wpt>
#  <wpt lat="52.1531526" lon="5.02283559999999">
#    <name>Alexis</name>
#  </wpt>
#</gpx>
	xml = Builder::XmlMarkup.new(:indent => 2)
    xml.instruct!
	xml.gpx("version"=>"1.1",
		"creator"=>"LocalizeTeaPot server",
		"xmlns"=>"http://www.topografix.com/GPX/1/1",
		"xmlns:xsi"=>"http://www.w3.org/2001/XMLSchema-instance",
		"xsi:schemaLocation"=>"http://www.topografix.com/GPX/1/1 http://www.topografix.com/GPX/1/1/gpx.xsd"
		) do
	  self.friendships.each do |friend|
		@friendc = User.find(friend.friend_id);
		@status = Status.find_by_user_id(friend.friend_id)
	    xml.wpt("lat"=>@status.latitude,"lon"=>@status.longitude) do
		  xml.name(@friendc.login)
		  xml.desc(@status.message)
		  xml.time(@status.updated_at)
		end
	  end
	end
  end
end