class StatutsController < ApplicationController
  # GET /statuts
  # GET /statuts.xml
  def index
    @statuts = Statut.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @statuts }
    end
  end

  # GET /statuts/1
  # GET /statuts/1.xml
  def show
    @statut = Statut.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @statut }
    end
  end

  # GET /statuts/new
  # GET /statuts/new.xml
  def new
    @statut = Statut.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @statut }
    end
  end

  # GET /statuts/1/edit
  def edit
    @statut = Statut.find(params[:id])
  end

  # POST /statuts
  # POST /statuts.xml
  def create
    @statut = Statut.new(params[:statut])

    respond_to do |format|
      if @statut.save
        flash[:notice] = 'Statut was successfully created.'
        format.html { redirect_to(@statut) }
        format.xml  { render :xml => @statut, :status => :created, :location => @statut }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @statut.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /statuts/1
  # PUT /statuts/1.xml
  def update
    @statut = Statut.find(params[:id])

    respond_to do |format|
      if @statut.update_attributes(params[:statut])
        flash[:notice] = 'Statut was successfully updated.'
        format.html { redirect_to(@statut) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @statut.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /statuts/1
  # DELETE /statuts/1.xml
  def destroy
    @statut = Statut.find(params[:id])
    @statut.destroy

    respond_to do |format|
      format.html { redirect_to(statuts_url) }
      format.xml  { head :ok }
    end
  end
end
