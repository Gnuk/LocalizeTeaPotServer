class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Account registered!"
      redirect_back_or_default user_url(@user)
    else
      render :action => :new
    end
  end
  
  def show
    @user = @current_user    	
    @status = Status.find_last_by_user_id(@user)
	unless @status
		@status = Status.new
	  	@status.message = "This user never published a status"
	  	@status.latitude = 45.6439
	  	@status.longitude = 5.86805
	end
    
    #Google map
    @map = GMap.new("map_div")#name of the html element that will hold the map
    @map.control_init(:large_map_3D => true, :hierarchical_map_type => true)
    @map.set_map_type_init(GMapType::G_SATELLITE_3D_MAP)
    @map.interface_init(:scroll_wheel_zoom => true, :continuous_zoom => true, :info_window => true, :dragging => true)
    @map.center_zoom_init([@status.latitude,@status.longitude],10)
    @map.overlay_init(GMarker.new([@status.latitude,@status.longitude],:title => @status.message))
    @map.enableScrollWhellZoom(true);
    
    #IPGeoloc
    add_marker_for(@user.current_login_ip, "You", "According to your IP address, we detected that you may be here.")

  end
 
  def edit
    @user = @current_user
  end
  
  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to user_url(current_user.id)
    else
      render :action => :edit
    end
  end
  
  def search
  	@search = User.search(params[:search])
	@users, @users_count = @search.all, @search.count
  end
  
  private

  def add_marker_for(address, login, message)
    position = Geokit::Geocoders::MultiGeocoder.geocode(address)
    if message.nil?
    	message = "No Status"
    end
    gmarker = GMarker.new([position.lat,position.lng], :title => login, :info_window => '<h1>'+login+'</h1><em class="status_message_info">&laquo;'+message+'&raquo;</em>')
    @map.overlay_init(gmarker)
  end

end