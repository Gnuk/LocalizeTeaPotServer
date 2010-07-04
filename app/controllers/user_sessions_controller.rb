class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
	print "ip:"
	print request.env["HTTP_X_FORWARDED_FOR"]
	if defined? request.env["HTTP_X_FORWARDED_FOR"] then
		#@user_session.current_login_ip = request.env["HTTP_X_FORWARDED_FOR"]
	end
    if @user_session.save
      flash[:notice] = "Login successful!"
	  
      redirect_back_or_default user_url(User.find_by_login(@user_session.login).id)
    else
      render :action => :new
    end
  end
  
  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_back_or_default new_session_url
  end
end