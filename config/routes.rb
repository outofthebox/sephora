Sephora::Application.routes.draw do
  root :to => "productos#index"
  get   "marca/:slug",  :to => "marcas#show", :as => "marca_ver"
  get   "producto/:slug",  :to => "productos#show", :as => "producto_ver"
  scope :path_names => {:new => "registrar", :edit => "editar"} do
    resources :productos
    resources :marcas
  end
end
