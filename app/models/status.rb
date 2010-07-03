class Status < ActiveRecord::Base
  belongs_to :user, :foreign_key => "user_id"
  attr_accessor :address

# <ltp version="0.1" generator="GoPens Android client">
 #  <gpx_file 
 #    lat="53.285644054" lon="-6.238367558" 
 #    user="robfitz" public="true" pending="false" 
 #    timestamp="2010-01-13T23:28:41+01:00"/>
 #</ltp>

    def to_xml(options = {})
      options[:indent] ||= 2
      xml = options[:builder] ||= Builder::XmlMarkup.new(:indent => options[:indent])
      xml.instruct! unless options[:skip_instruct]
	  print "userid:"
	  print self.user_id
	  @user = User.find(self.user_id);
	  xml.ltp("version"=>"0.1","generator"=>"LTP server") do
	    xml.gpx_file(message,"lat"=>latitude,"lon"=>longitude, "user"=>@user.login, "timestamp"=>updated_at)
      end
    end
	
end
