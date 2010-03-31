class FriendshipsController < ApplicationController
  before_filter :require_user

  def index
  	@friendships = Friendship.find_all_by_user_id(current_user.id)
  	
  	respond_to do |format|
  		format.html
  	end
  end
  
  def show
  	@friendship = Friendship.find(params[:id])
  	if @friendship.user_id != current_user.id
  		flash[:notice] = "Sorry, you can only check your friends' profiles!"
  		redirect_back_or_default user_friendships_url
  	else
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
  
  end
  
  def update
  
  end
  
  def destroy
  	@friendship = Friendship.find(params[:id])
  	@friendship.destroy
  	flash[:notice] = "Friendship cancelled!"
  	redirect_to(user_friendships_url)
  end
  
end