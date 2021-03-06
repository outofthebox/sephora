class UsuariosController < ApplicationController
  include Devise::Controllers::Rememberable
  load_and_authorize_resource :only => [:actualizar, :list, :usar_sesion]

  def perfil; redirect_to usuario_wishlist_path; end
  def bienvenido; end

  def actualizar
    @usuario = Usuario.find params[:id]
    @usuario.rol = params[:usuario][:rol]
    @usuario.save

    redirect_to request.referer
  end

  def lista
    @usuarios = Usuario.order("created_at DESC");

    respond_to do |format|
      format.html
    end
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

  def wishlist
    @wishlist = Producto.where(:upc => ["815517020584", "604214919006", "607710042148", "5045456747685", "687795470012", "3378872096016", "607845021124", "818015011832", "3349668508587", "851610005301"])
    @usuario = current_usuario.productos rescue []
    @bandera = (current_usuario) ? true : false
  end

  def wishlist_ver
    usuario_id = params[:slug].match(/([0-9]+)/)[0] rescue nil
    @usuario = Usuario.find(usuario_id).productos rescue []

  end

  def wishlist_del
    producto = Producto.find_by_upc(params[:upc])
    if producto
      current_usuario.productos.delete(producto)
      status = {:status => "exito", :error => nil}.to_json
    else
      status = {:status => "error", :error => "el producto no existe o ya fue eliminado"}.to_json
    end
    render :json => status
  end

  def wishlist_add
    producto = Producto.find_by_upc(params[:upc])
    if producto
      current_usuario.productos << producto
      status = {:status => "exito", :error => nil}.to_json
    else
      status = {:status => "error", :error => "el producto no existe"}.to_json
    end
    render :json => status
  end
end
