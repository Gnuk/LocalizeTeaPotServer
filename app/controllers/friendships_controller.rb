class FriendshipsController < ApplicationController
  before_filter :require_user, :only => [:create, :new]
  def index
  
  end
  def show
  
  end
  def new
    @friendship = Friendship.new
  end
  def create
     friend = User.find_by_login(params[:friendship][:friend_login])
     if friend
       params[:friendship][:friend_id] = friend.id
       params[:friendship].delete(:friend_login)
       @friendship = Friendship.new(params[:friendship])
       if @friendship.save
         flash[:notice] = "Friendship initiated!"
         redirect_back_or_default friendship_url
       else
         render :action => :new
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
  
  end
end