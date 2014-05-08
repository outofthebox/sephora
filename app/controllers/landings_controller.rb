class LandingsController < ApplicationController
  layout "administracion"
  # GET /landings
  # GET /landings.json
  def index
    @landings = Landing.all
  end

  # GET /landings/1
  # GET /landings/1.json
  def show
    @landing = Landing.find(params[:id])
  end

  # GET /landings/new
  # GET /landings/new.json
  def new
    @landing = Landing.new
    @marcas = Marca.all
  end

  # GET /landings/1/edit
  def edit
    @landing = Landing.find(params[:id])
    @marcas = Marca.all
  end

  # POST /landings
  # POST /landings.json
  def create
    @landing = Landing.new(params[:landing])
    if @landing.save
      redirect_to admin_landing_path
    end
  end

  # PUT /landings/1
  # PUT /landings/1.json
  def update
    @landing = Landing.find(params[:id])
  end

  # DELETE /landings/1
  # DELETE /landings/1.json
  def destroy
    @landing = Landing.find(params[:id])
    @landing.destroy
  end
end
