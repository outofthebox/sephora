class InstagramController < ApplicationController
  def index
  	@fotos = Foto.where(:publicado => false).order('created_at DESC').all
  end

  def new_stuff
    variable = request.body.read
    raise variable.inspect;
  end

  def suscribir
    render :text => "#{params['hub.challenge']}"
  end
end
