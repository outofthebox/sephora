Sephora::Application.routes.draw do
  root :to => "productos#index"
  scope :path_names => {:new => "registrar", :edit => "editar"} do
    resources :productos
    resources :marcas
  end
end
