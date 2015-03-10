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
      format.csv {
        csv_string = CSV.generate do |csv|
          csv << Usuario.attribute_names
          @usuarios.each do |u|
            csv << u.attributes.values
          end
        end
        render :text => csv_string
      }
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
    @wishlist = Producto.where(:upc => ["3378872082286", "713757240833", "670367001653", "651043024517", "651043021523", "670367001257", "808144222018", "3378872072713", "817574010447", "873509022787", "814591011266", "3346470402621", "818015012921", "020714576219", "3378872079064"])
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
