Sephora::Application.routes.draw do
  root :to => "paginas#home"


  get   "secciones/:id/desvincular/:producto_seccion/:hash", :to => "secciones#desvincular", :as => "seccion_desvincular_producto"
  get   "secciones/:id/vincular/:v_id/editar", :to => "secciones#producto_editar", :as => "seccion_editar_producto"
  put   "secciones/:id/vincular/:v_id/editar", :to => "secciones#producto_update"
  post  "secciones/:id/vincular", :to => "secciones#vincular", :as => "seccion_vincular_producto"
  post  "secciones/actualizar_orden", :to => "secciones#actualizar_orden"

  get   "importar(/:quoi)", :to => "utilidades#importar"
  get   "importarimg", :to => "utilidades#importarimg"
  
  get   "producto", :to => "productos#index"
  get   "producto/:slug",  :to => "productos#show", :as => "producto_ver"
  get   "productos/busqueda", :to => "productos#busqueda", :as => "productos_busqueda"
  
  get   "marca", :to => "marcas#index"
  get   "marca/:slug",  :to => "marcas#show", :as => "marca_ver"

  get   "admin/productos", :to => "productos#index_admin"

  get   "contacto", :to => "paginas#contacto", :as => "contacto"
  post  "contacto", :to => "paginas#contacto_post"

  get   "suscripcion", :to => "paginas#suscripcion", :as => "suscripcion"
  post  "suscripcion", :to => "paginas#suscripcion_post"

  # get   "categoria/:categoria", :to => "categorias#ver", :as => "categoria"
  scope :path_names => {:new => "registrar", :edit => "editar"} do
    resources :productos
    resources :marcas
    resources :categorias
    resources :secciones
  end

end
