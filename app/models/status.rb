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
	  @user = User.find(user_id);
	  xml.ltp("version"=>"0.1","generator"=>"LTP server") do
	    xml.gpx_file(message,"lat"=>latitude,"lon"=>longitude, "user"=>@user.login,"timestamp"=> updated_at.iso8601)
      end
    end
	
#	{"ltp":
# {"@version":"0.1",
#  "@generator":"LocalizeTeaPot iPhone client",
#  "gpx_file":
#    {"@lat":"53.285644054",
#     "@lon":"-6.238367558",
#     "@user":"robfitz",
#   }
# }
#}

  def to_json(options = {})
    json = options[:builder] ||= Hash.new
	ltp = Hash.new
	ltp[:@version] = "0.1"
	ltp[:@generator] = "LocalizeTeaPot iPhone client"
    gpx = Hash.new
	@user = User.find(user_id);
	gpx[:message] = message
	gpx[:@lat] = latitude
	gpx[:@lon] = longitude
	gpx[:@user] = @user.login
	gpx[:@timestamp] = updated_at
	ltp[:gpx_file] = gpx
	json[:ltp] = ltp
    json.to_json
  end
	
end
