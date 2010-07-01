class FriendshipsController < ApplicationController
  before_filter :require_user

  def index
  	@friendships = Friendship.find_all_by_user_id(current_user.id)
  	
  	#Google map
    @map = GMap.new("friends_map")#name of the html element that will hold the map
    @map.control_init(:large_map_3D => true, :hierarchical_map_type => true)
    @map.set_map_type_init(GMapType::G_SATELLITE_3D_MAP)
    @map.interface_init(:scroll_wheel_zoom => true, :continuous_zoom => true, :info_window => true, :dragging => true)
    @map.enableScrollWhellZoom(true);

	@friendships.each do |friend|
		friend.status = Status.find_last_by_user_id(friend.friend_id)
		if friend.status
			@map.center_zoom_init([friend.status.latitude, friend.status.longitude],10)
			login = User.find(friend.friend_id).login
			@map.overlay_init(GMarker.new([friend.status.latitude, friend.status.longitude], :title => login, :info_window => '<h1>'+login+'</h1><em class="status_message_info">&laquo;'+friend.status.message+'&raquo;</em>'))
		end
	end
  	
  	respond_to do |format|
  		format.html
  	end
  end
 
  def servenew
  	@friendships = Friendship.find_all_by_user_id(current_user.id)

	xml = Builder::XmlMarkup.new()
    xml.instruct!
	xml.friendships do
	  @friendships.each do |friend|
		@friendc = User.find(friend.friend_id);
	    xml.user(@friendc.to_xml(:skip_instruct => true, :include =>[:friend_id]))
	    @friendc.to_xml(:skip_instruct => true, :include =>[:friend_id])
	  end
	end

	respond_to do |format|
	  format.xml { render :xml => xml}
	  format.all { redirect_to :action => :index }
	end
  end

	
  def serve
  	@friendships = Friendship.find_all_by_user_id(current_user.id)
	respond_to do |format|
	    format.html { redirect_to :action => :index }
        format.json { render :json => @friendships }
		format.xml { render :xml => @friendships }
	end
  end

  def servestatuses
	respond_to do |format|
	  format.xml { render :xml => current_user.to_friendships_xml}
	  format.all { redirect_to :action => :index }
	end
  end
    
  def show
  	@friendship = Friendship.find(params[:id])
  	if @friendship.user_id != current_user.id
  		flash[:notice] = "Sorry, you can only check your friends' profiles!"
  		redirect_back_or_default user_friendships_url
  	else
		@last_status = Status.find_last_by_user_id(@friendship.friend_id)
	  	if @last_status.nil?
	  		@last_status = Status.new
	  		@last_status.message = "This user never published a status"
	  		@last_status.latitude = 0
	  		@last_status.longitude = 0
	  	end
	  	#Google map
	    @map = GMap.new("friends_map")#name of the html element that will hold the map
	    @map.control_init(:large_map_3D => true, :hierarchical_map_type => true)
	    @map.set_map_type_init(GMapType::G_SATELLITE_3D_MAP)
	    @map.interface_init(:scroll_wheel_zoom => true, :continuous_zoom => true, :info_window => true, :dragging => true)
	    @map.enableScrollWhellZoom(true);
	    login = User.find(@friendship.friend_id).login
	    @map.center_zoom_init([@last_status.latitude, @last_status.longitude],10)
	    @map.overlay_init(GMarker.new([@last_status.latitude, @last_status.longitude], :title => @last_status.message, :info_window => '<h1>'+login+'</h1><em class="status_message_info">&laquo;'+@last_status.message+'&raquo;</em>'))

	  	respond_to do |format|
	  		format.html
	  	end
	end
  end
  
  def new
    @friendship = Friendship.new
    @search = User.search
  end
  def create
	friend = User.find_by_login(params[:friendship][:friend_login])
	if friend
		params[:friendship][:friend_id] = friend.id
		params[:friendship].delete(:friend_login)
		@friendship = Friendship.new(params[:friendship])
		if @friendship.save
			flash[:notice] = "Friendship initiated!"
		  	redirect_to(user_friendships_url)
		else
			flash[:notice] = "An unknown error occurred while processing your request!"
		  	redirect_to(user_friendships_url)
		end
	else
		flash[:notice] = "User doesn't exist!"
		@friendship = Friendship.new
		render :action => :new
	end
  end
  
  def edit
    @friendship = Friendship.find(params[:id])
  end
  
  def update
    @friendship = Friendship.find(params[:id])
	friend = User.find_by_login(params[:friendship][:friend_login])
	if friend
		params[:friendship][:friend_id] = friend.id
		params[:friendship].delete(:friend_login)
	    if @friendship.update_attributes(params[:friendship])
	      flash[:notice] = "Friendship updated!"
	      redirect_to user_friendship_url
	    else
	      render :action => :edit
	    end
	else
		flash[:notice] = "User doesn't exist!"
		@friendship = Friendship.find(params[:id])
		render :action => :edit	
	end
    debugger

  end
  
  def destroy
  	@friendship = Friendship.find(params[:id])
  	@friendship.destroy
  	flash[:notice] = "Friendship cancelled!"
  	redirect_to(user_friendships_url)
  end
  
end