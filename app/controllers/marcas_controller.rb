class MarcasController < ApplicationController
  def index
    @marcas = Marca.all
  end

  def new
    @marca = Marca.new
  end

  def create
    @marca = Marca.new params[:marca]
    if @marca.save
      redirect_to marca_path(@marca.id)
    else
      render :new
    end
  end

  def edit
    @marca = Marca.find params[:id]
  end

  def update
    @marca = Marca.find params[:id]
    if @marca.update_attributes params[:marca]
      redirect_to marca_path(@marca.id)
    else
      render :edit
    end
  end

  def show
    @marca = Marca.find params[:id]
  end

  def destroy
    Marca.delete params[:id]
    redirect_to marcas_path
  end
end
