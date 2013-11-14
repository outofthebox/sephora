class InstagramController < ApplicationController
  def index
  	@fotos = Foto.where(:publicado => false).order('created_at DESC').all
  end

  def new_stuff
   
  end

  def suscribir
    render :text => "#{params['hub.challenge']}"
  end
end
