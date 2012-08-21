class UsuariosController < ApplicationController
  include Devise::Controllers::Rememberable
  load_and_authorize_resource :except => [:logout, :ver]

  def lista
    @usuarios = Usuario.order("id DESC")
  end

  def actualizar
    @usuario = Usuario.find params[:id]
    @usuario.rol = params[:usuario][:rol]
    @usuario.save

    redirect_to request.referer
  end

  def usar_sesion
    @usuario = Usuario.find params[:id]
    remember_me @usuario
    sign_in_and_redirect @usuario, :event => :authentication
  end

  def logout
    if check_minihash('adios', params[:hash])
      sign_out current_usuario
    end
    redirect_to :root
  end
end
