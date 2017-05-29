class CampaingLandingsController < ApplicationController
  # GET /campaing_landings
  # GET /campaing_landings.json
  def index
    @campaing_landings = CampaingLanding.all

    #@campaing_landings = []

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @campaing_landings }
    end
  end

  # GET /campaing_landings/1
  # GET /campaing_landings/1.json
  def show
    @campaing_landing = CampaingLanding.find_by_vanity_url(params[:slug])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @campaing_landing }
    end
  end

  # GET /campaing_landings/new
  # GET /campaing_landings/new.json
  def new
    @campaing_landing = CampaingLanding.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @campaing_landing }
    end
  end

  # GET /campaing_landings/1/edit
  def edit
    @campaing_landing = CampaingLanding.find(params[:id])
  end

  # POST /campaing_landings
  # POST /campaing_landings.json
  def create
    @campaing_landing = CampaingLanding.new(params[:campaing_landing])

    respond_to do |format|
      if @campaing_landing.save
        format.html { redirect_to @campaing_landing, notice: 'CampaingLanding was successfully created.' }
        format.json { render json: @campaing_landing, status: :created, location: @campaing_landing }
      else
        format.html { render action: "new" }
        format.json { render json: @campaing_landing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /campaing_landings/1
  # PUT /campaing_landings/1.json
  def update
    @campaing_landing = CampaingLanding.find(params[:id])

    respond_to do |format|
      if @campaing_landing.update_attributes(params[:campaing_landing])
        format.html { redirect_to @campaing_landing, notice: 'CampaingLanding was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @campaing_landing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campaing_landings/1
  # DELETE /campaing_landings/1.json
  def destroy
    @campaing_landing = CampaingLanding.find(params[:id])
    @campaing_landing.destroy

    respond_to do |format|
      format.html { redirect_to campaing_landings_url }
      format.json { head :no_content }
    end
  end
end
