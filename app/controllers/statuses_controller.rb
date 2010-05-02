class StatusesController < ApplicationController
	before_filter :require_user
	
	def index
	  	@statuses = Status.all# - Status.find_by_user_id(current_user.id)
	  	respond_to do |format|
	  		format.html
	  	end
	end
	
	def new
		position = Geokit::Geocoders::MultiGeocoder.geocode(current_user.current_login_ip)
		@status = Status.new :latitude => position.lat, :longitude => position.lng
	end
	
	def create
	    @status = Status.new(params[:status])
	    if @status.save
	    	flash[:notice] = "Status updated successfully!"
		  	redirect_back_or_default user_statuses_url(current_user.id)
	    else
	      render :action => :new
	    end
	end
	
  def createfromput
	doc = REXML::Document.new(request.body);
	latAttr = REXML::XPath.first(doc,"/ltp/gpx_file/@lat")
	lngAttr = REXML::XPath.first(doc,"/ltp/gpx_file/@lon")
	message = REXML::XPath.first(doc,"/ltp/gpx_file/text()")
	@status = Status.find_by_user_id(current_user.id)
	if @status then
		@status.update_attributes(:message => message.value, :latitude => latAttr.value, :longitude => lngAttr.value)
	else
		@status = Status.new(:message => message, :latitude => latAttr.value, :longitude => lngAttr.value)
	end
	@status.save
	respond_to do |format|
	    format.html { redirect_to :action => :index }
        format.json { render :json => @status }
		format.xml { render :xml => @status }
	end
  end

  def serve
  	@status = Status.find_by_user_id(current_user.id)
	respond_to do |format|
	    format.html { redirect_to :action => :index }
        format.json { render :json => @status }
		format.xml { render :xml => @status }
	end
  end

	def show
		@status = Status.find(params[:id])
		@friend = User.find(params[:user_id])
		respond_to do |format|
			format.html
		end
	end
	
	def edit
		@status = Status.find(params[:id])
	end
	
	def update
	    @status = Status.find(params[:id])
	    if @status.update_attributes(params[:status])
	      flash[:notice] = "Status updated!"
	      redirect_to user_status_url
	    else
	      render :action => :edit
	    end
	end
	
	def destroy
		@status = Status.find(params[:id])
		@status.destroy
		flash[:notice] = "Status removed!"
		redirect_to(user_statuses_url)
	end
end
