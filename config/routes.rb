Sephora::Application.routes.draw do
  root :to => "paginas#home"
  root :to => "productos#index"
  scope :path_names => {:new => "registrar", :edit => "editar"} do
    resources :productos
    resources :marcas
  end

  get   "producto", :to => "productos#index"
  get   "producto/:slug",  :to => "productos#show", :as => "producto_ver"
  
  get   "marca", :to => "marcas#index"
  get   "marca/:slug",  :to => "marcas#show", :as => "marca_ver"

  get   "admin/productos", :to => "productos#index_admin"

  get   "contacto", :to => "paginas#contacto", :as => "contacto"
  post  "contacto", :to => "paginas#contacto_post"

  get "suscripcion", :to => "paginas#suscripcion", :as => "suscripcion"
  post "suscripcion", :to => "paginas#suscripcion_post"
end
