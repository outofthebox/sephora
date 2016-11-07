class Administracion::AnimationsController < ApplicationController
  layout "administracion"
  
  # GET /administracion/animations
  # GET /administracion/animations.json
  def index
    @animations = Animation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @animations }
    end
  end

  # GET /administracion/animations/1
  # GET /administracion/animations/1.json
  def show
    @animation = Animation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @animation }
    end
  end

  # GET /administracion/animations/new
  # GET /administracion/animations/new.json
  def new
    @animation = Animation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @animation }
    end
  end

  # GET /administracion/animations/1/edit
  def edit
    @animation = Animation.find(params[:id])
  end

  # POST /administracion/animations
  # POST /administracion/animations.json
  def create
    @animation = Animation.new(params[:animation])

    respond_to do |format|
      if @animation.save
        format.html { redirect_to @animation, notice: 'Animation was successfully created.' }
        format.json { render json: @animation, status: :created, location: @animation }
      else
        format.html { render action: "new" }
        format.json { render json: @animation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /administracion/animations/1
  # PUT /administracion/animations/1.json
  def update
    @animation = Animation.find(params[:id])

    respond_to do |format|
      if @animation.update_attributes(params[:animation])
        format.html { redirect_to @animation, notice: 'Animation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @animation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /administracion/animations/1
  # DELETE /administracion/animations/1.json
  def destroy
    @animation = Animation.find(params[:id])
    @animation.destroy

    respond_to do |format|
      format.html { redirect_to admin_animations_url }
      format.json { head :no_content }
    end
  end
end
