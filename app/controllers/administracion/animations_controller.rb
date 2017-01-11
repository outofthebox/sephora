class Administracion::AnimationsController < ApplicationController
  layout "administracion"
  
  # GET /animations
  # GET /animations.json
  def index
    @animations = Animation.all

    #@animations = []

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @animations }
    end
  end

  # GET /animations/1
  # GET /animations/1.json
  def show
    @animation = Animation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @animation }
    end
  end

  # GET /animations/new
  # GET /animations/new.json
  def new
    @animation = Animation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @animation }
    end
  end

  # GET /animations/1/edit
  def edit
    @animation = Animation.find(params[:id])
  end

  # POST /animations
  # POST /animations.json
  def create
    @animation = Animation.new(params[:animation])

    respond_to do |format|
      if @animation.save
        format.html { redirect_to @animation, notice: 'animation was successfully created.' }
        format.json { render json: @animation, status: :created, location: @animation }
      else
        format.html { render action: "new" }
        format.json { render json: @animation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /animations/1
  # PUT /animations/1.json
  def update
    @animation = Animation.find(params[:id])

    respond_to do |format|
      if @animation.update_attributes(params[:animation])
        format.html { redirect_to @animation, notice: 'animation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @animation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /animations/1
  # DELETE /animations/1.json
  def destroy
    @animation = Animation.find(params[:id])
    @animation.destroy

    respond_to do |format|
      format.html { redirect_to animations_url }
      format.json { head :no_content }
    end
  end
end
