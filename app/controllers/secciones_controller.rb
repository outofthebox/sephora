class SeccionesController < ApplicationController
  def index
    @secciones = Seccion.order
  end

  def show
    @seccion = Seccion.find params[:id]
  end

  def new
    @seccion = Seccion.new
  end

  def create
    @seccion = Seccion.create params[:seccion]
    if @seccion.valid?
      @seccion.save
      redirect_to new_seccion_path
    else
      render :new
    end
  end

  def edit
    @seccion = Seccion.find params[:id]
  end

  def update
    @seccion = Seccion.find params[:id]
    @seccion.update_attributes params[:seccion]
    if @seccion.valid?
      @seccion.save
      redirect_to edit_seccion_path(params[:id])
    else
      render :edit
    end
  end

  def destroy
  end
end
