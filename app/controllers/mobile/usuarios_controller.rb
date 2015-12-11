class Mobile::UsuariosController < MobileController
  before_filter :authenticate_usuario!


  def lista; @usuarios = Usuario.order("id DESC"); end
  def perfil; redirect_to m_usuario_wishlist_path; end
  def bienvenido; end
  def show; end

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

  def wishlist
    @wishlist = Producto.where(:upc => ["3378872084327", "3378872084358", "602004060990", "812738013951", "602004065810", "20714695736", "811999020500", "3548752072601", "94800348455", "879634007453", "811999020388", "604214923027", "651043071818", "682223080931", "687795456016", "607710038479", "689304452168", "607845083054", "809280123252", "8410225531425", "20714695453", "3349668526284", "737052756370", "8411061788813", "651986905379"])
    @usuario = current_usuario.productos rescue []
    @bandera = (current_usuario) ? true : false
    redirect_to new_m_usuario_session_path unless @bandera
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
