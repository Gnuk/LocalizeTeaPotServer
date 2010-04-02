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
      redirect_back_or_default users_url
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
    @map.control_init(:large_map => true,:map_type => true)
    @map.center_zoom_init([@status.latitude,@status.longitude],10)
    @map.overlay_init(GMarker.new([@status.latitude,@status.longitude],:title => @status.message))
    
    # @marker_icon= onomo_marker_icon

    add_marker_for('Dakar','Dakar Aeroport')
    add_marker_for('Abidjan')
    add_marker_for('Pointe Nore')
    add_marker_for('Brazzaville')
    add_marker_for('Mali')
    add_marker_for('Kinshasa')
    add_marker_for('Accra')
    add_marker_for('Lome')
    add_marker_for('Ouada')
    add_marker_for('Douala')
    add_marker_for('Malabo')
    add_marker_for('Libreville')
    add_marker_for('Luanda, Angola')
    add_marker_for('Johannesbourg')
    add_marker_for('88.187.224.193')

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

  def add_marker_for(address,title=address)
    position = Geokit::Geocoders::MultiGeocoder.geocode(address)
    gmarker = GMarker.new([position.lat,position.lng],
      :title => title
    )
    @map.overlay_init(gmarker)
  end

end