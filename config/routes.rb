Sephora::Application.routes.draw do
  root :to => "productos#index"
  resources :productos
end
