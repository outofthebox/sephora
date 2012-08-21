Sephora::Application.routes.draw do
  devise_for :usuarios

  root :to => "paginas#home"
  scope :path_names => {:new => "registrar", :edit => "editar"} do
    resources :productos
    resources :marcas
    resources :categorias
  end


  get   'usuarios/lista', :to => 'usuarios#lista', :as => 'usuarios_lista'
  put   'usuario/actualizar/:id', :to => 'usuarios#actualizar', :as => 'usuario_actualizar'
  get   'usuario/usar_sesion/:id', :to => 'usuarios#usar_sesion', :as => 'usuario_usar_sesion'
  get   'logout(/:hash)', :to => 'usuarios#logout', :as => 'logout'


  get   "importar(/:quoi)", :to => "utilidades#importar"
  get   "importarimg", :to => "utilidades#importarimg"
  
  get   "producto", :to => "productos#index"
  get   "producto/:slug",  :to => "productos#show", :as => "producto_ver"
  
  get   "marca", :to => "marcas#index"
  get   "marca/:slug",  :to => "marcas#show", :as => "marca_ver"

  get   "admin/productos", :to => "productos#index_admin"

  get   "contacto", :to => "paginas#contacto", :as => "contacto"
  post  "contacto", :to => "paginas#contacto_post"

  get   "suscripcion", :to => "paginas#suscripcion", :as => "suscripcion"
  post  "suscripcion", :to => "paginas#suscripcion_post"

  # get   "categoria/:categoria", :to => "categorias#ver", :as => "categoria"
end
