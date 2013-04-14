class TiendasController < ApplicationController
  def index
    @tiendas = Tienda.all
  end

  def show
    @tienda = Tienda.find_by_slug(params[:id])
  end

  def new
    @tienda = Tienda.new
    authorize! :manage, @tienda
  end

  def create
    @tienda = Tienda.new(params[:tienda])
    if @tienda.save
      redirect_to tienda_path(@tienda.slug), :notice => "Successfully created tienda."
    else
      render :action => 'new'
    end
    authorize! :manage, @tienda
  end

  def edit
    @tienda = Tienda.find(params[:id])
    authorize! :manage, @tienda
  end

  def update
    @tienda = Tienda.find(params[:id])
    if @tienda.update_attributes(params[:tienda])
      redirect_to tienda_path(@tienda.slug), :notice  => "Successfully updated tienda."
    else
      render :action => 'edit'
    end
    authorize! :manage, @tienda
  end

  def destroy
    @tienda = Tienda.find(params[:id])
    @tienda.destroy
    redirect_to tiendas_url, :notice => "Successfully destroyed tienda."
    authorize! :manage, @tienda
  end
end
