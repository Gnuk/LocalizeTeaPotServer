class StatusesController < ApplicationController
	before_filter :require_user
	
	def index
	  	@statuses = Status.all# - Status.find_by_user_id(current_user.id)
	  	respond_to do |format|
	  		format.html
	  	end
	end
	
	def new
		@status = Status.new
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
	
	def show
		@status = Status.find(params[:id])
		@friend = User.find(params[:user_id])
		respond_to do |format|
			format.html
		end
	end
	
	def destroy
		@status = Status.find(params[:id])
		@status.destroy
		flash[:notice] = "Status removed!"
		redirect_to(user_statuses_url)
	end
end
