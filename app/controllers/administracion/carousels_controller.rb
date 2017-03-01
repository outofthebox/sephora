class Administracion::CarouselsController < ApplicationController
  layout "administracion"
  before_filter :set_carousel_animation
  
  # GET /carousels
  # GET /carousels.json
  def index
    @carousels = @carousel_animation.carousels.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @carousels }
    end
  end

  # GET /carousels/1
  # GET /carousels/1.json
  def show
    @carousel = @carousel_animation.carousels.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @carousel }
    end
  end

  # GET /carousels/new
  # GET /carousels/new.json
  def new
    @carousel = @carousel_animation.carousels.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @carousel }
    end
  end

  # GET /carousels/1/edit
  def edit
    @carousel = @carousel_animation.carousels.find(params[:id])
  end

  # POST /carousels
  # POST /carousels.json
  def create
    @carousel = @carousel_animation.carousels.new(params[:carousel])

    respond_to do |format|
      if @carousel.save
        format.html { redirect_to @carousel, notice: 'Carousel was successfully created.' }
        format.json { render json: @carousel, status: :created, location: @carousel }
      else
        format.html { render action: "new" }
        format.json { render json: @carousel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /carousels/1
  # PUT /carousels/1.json
  def update
    @carousel = @carousel_animation.carousels.find(params[:id])

    respond_to do |format|
      if @carousel.update_attributes(params[:carousel])
        format.html { redirect_to @carousel, notice: 'Carousel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @carousel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carousels/1
  # DELETE /carousels/1.json
  def destroy
    @carousel = @carousel_animation.carousels.find(params[:id])
    @carousel.destroy

    respond_to do |format|
      format.json { head :no_content }
      format.html { redirect_to carousels_url }
    end
  end

  def set_carousel_animation
    if params[:animation_carousel_id].present?
      @carousel_animation = AnimationCarousel.find(params[:animation_carousel_id])
    else
      @carousel_animation = Carousel.find(params[:id]).animation_carousel
    end
  end
end
