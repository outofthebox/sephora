class Administracion::AnimationCarouselsController < ApplicationController
  layout "administracion"
  
  # GET /animation_carousels
  # GET /animation_carousels.json
  def index
    @animation_carousels = AnimationCarousel.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @animation_carousels }
    end
  end

  # GET /animation_carousels/1
  # GET /animation_carousels/1.json
  def show
    @animation_carousel = AnimationCarousel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @animation_carousel }
    end
  end

  # GET /animation_carousels/new
  # GET /animation_carousels/new.json
  def new
    @animation_carousel = AnimationCarousel.new
    #@animation_carousel.carousels << Carousel.new if @animation_carousel.carousels.count == 0
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @animation_carousel }
    end
  end

  # GET /animation_carousels/1/edit
  def edit
    @animation_carousel = AnimationCarousel.find(params[:id])
    @carousel = Carousel.new({animation_carousel: @animation_carousel})
  end

  # POST /animation_carousels
  # POST /animation_carousels.json
  def create
    @animation_carousel = AnimationCarousel.new(params[:animation_carousel])

    respond_to do |format|
      if @animation_carousel.save
        format.html { redirect_to @animation_carousel, notice: 'AnimationCarousel was successfully created.' }
        format.json { render json: @animation_carousel, status: :created, location: @animation_carousel }
      else
        format.html { render action: "new" }
        format.json { render json: @animation_carousel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /animation_carousels/1
  # PUT /animation_carousels/1.json
  def update
    @animation_carousel = AnimationCarousel.find(params[:id])

    respond_to do |format|
      if @animation_carousel.update_attributes(params[:animation_carousel].except(:carousel))
        format.html { redirect_to @animation_carousel, notice: 'AnimationCarousel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @animation_carousel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /animation_carousels/1
  # DELETE /animation_carousels/1.json
  def destroy
    @animation_carousel = AnimationCarousel.find(params[:id])
    @animation_carousel.destroy

    respond_to do |format|
      format.html { redirect_to animation_carousels_url }
      format.json { head :no_content }
    end
  end

  #AJAX add carousel
  def add_carousel

    @animation_carousel = AnimationCarousel.find(params[:animation_carousel_id])
    @carousel = @animation_carousel.carousels.create(params[:animation_carousel][:carousel])

    respond_to do |format|
      format.js #add_carousel.js.erb
    end
  end
end
