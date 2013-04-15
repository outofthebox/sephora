class EventotiendasController < ApplicationController
  def index
    @eventotiendas = Eventotienda.all
    authorize! :manage, @eventotiendas
  end

  def show
    @eventotienda = Eventotienda.find(params[:id])
    authorize! :manage, @eventotienda
  end

  def new
    @eventotienda = Eventotienda.new
    @tiendas = Tienda.all
    authorize! :manage, @eventotienda
  end

  def create
    @eventotienda = Eventotienda.new(params[:eventotienda])
    if @eventotienda.save
      redirect_to tienda_path(Tienda.find(@eventotienda.tienda.id).slug), :notice => "Successfully created eventotienda."
    else
      render :action => 'new'
    end
    authorize! :manage, @eventotienda
  end

  def edit
    @eventotienda = Eventotienda.find(params[:id])
    @tiendas = Tienda.all
    authorize! :manage, @eventotienda
  end

  def update
    @eventotienda = Eventotienda.find(params[:id])
    if @eventotienda.update_attributes(params[:eventotienda])
      redirect_to @eventotienda, :notice  => "Successfully updated eventotienda."
    else
      render :action => 'edit'
    end
    authorize! :manage, @eventotienda
  end

  def destroy
    @eventotienda = Eventotienda.find(params[:id])
    @eventotienda.destroy
    redirect_to eventotiendas_url, :notice => "Successfully destroyed eventotienda."
    authorize! :manage, @eventotienda
  end
end
