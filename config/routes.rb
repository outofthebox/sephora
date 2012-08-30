Sephora::Application.routes.draw do
  devise_for :usuarios

  root :to => 'paginas#home'
  
  get   ':seccion', :to => 'secciones#ver', :constraints => { :seccion => /hotnow|bestsellers/ }
  get   'soluciones(/:id)', :to => 'secciones#soluciones', :as => 'soluciones'
  get   'favorites(/:id)', :to => 'secciones#favorites', :as => 'favorites'

  get   'secciones/:id/desvincular/:producto_seccion/:hash', :to => 'secciones#desvincular', :as => 'seccion_desvincular_producto'
  get   'secciones/:id/vincular/:v_id/editar', :to => 'secciones#producto_editar', :as => 'seccion_editar_producto'
  put   'secciones/:id/vincular/:v_id/editar', :to => 'secciones#producto_update'
  post  'secciones/:id/vincular', :to => 'secciones#vincular', :as => 'seccion_vincular_producto'
  post  'secciones/actualizar_orden', :to => 'secciones#actualizar_orden'

  get   'usuarios/lista', :to => 'usuarios#lista', :as => 'usuarios_lista'
  put   'usuario/actualizar/:id', :to => 'usuarios#actualizar', :as => 'usuario_actualizar'
  get   'usuario/usar_sesion/:id', :to => 'usuarios#usar_sesion', :as => 'usuario_usar_sesion'
  get   'logout(/:hash)', :to => 'usuarios#logout', :as => 'logout'

  get   'importar(/:quoi)', :to => 'utilidades#importar'
  get   'importarimg', :to => 'utilidades#importarimg'
  get   'parsearparents', :to => 'utilidades#parsearparents'
  
  get   'producto', :to => 'productos#index', :as => 'producto_index'
  get   'producto/:slug',  :to => 'productos#show', :as => 'producto_ver'
  get   'productos/busqueda', :to => 'productos#busqueda', :as => 'productos_busqueda'
  
  # get   'marca', :to => 'marcas#index'
  get   'marca/:slug',  :to => 'marcas#show', :as => 'marca_ver'

  get   'admin/productos', :to => 'productos#index_admin'

  get   'contacto', :to => 'paginas#contacto', :as => 'contacto'
  post  'contacto', :to => 'paginas#contacto_post'

  get   'tu-lista', :to => 'paginas#tulista'

  get   'tiendas', :to => 'paginas#tiendas', :as => 'tiendas'
  get   'eventos', :to => 'paginas#eventos', :as => 'eventos'
  get   'obsequios', :to => 'paginas#obsequios', :as => 'obsequios'

  get   'suscripcion', :to => 'paginas#suscripcion', :as => 'suscripcion'
  post  'suscripcion', :to => 'paginas#suscripcion_post'

  get   'categorias/:id/desvincular/:categoria_producto/:hash', :to => 'categorias#desvincular', :as => 'categoria_desvincular_producto'
  get   'categorias/:id/vincular/:v_id/editar', :to => 'categorias#producto_editar', :as => 'categoria_editar_producto'
  put   'categorias/:id/vincular/:v_id/editar', :to => 'categorias#producto_update'
  post  'categorias/:id/vincular', :to => 'categorias#vincular', :as => 'categoria_vincular_producto'
  post  'categorias/actualizar_orden', :to => 'categorias#actualizar_orden'
  get   'categoria(/:categoria)', :to => 'categorias#ver', :as => 'categoria_ver'  

  get   'marcas/:id/desvincular/:marca_producto/:hash', :to => 'marcas#desvincular', :as => 'marca_desvincular_producto'
  get   'marcas/:id/vincular/:v_id/editar', :to => 'marcas#producto_editar', :as => 'marca_editar_producto'
  put   'marcas/:id/vincular/:v_id/editar', :to => 'marcas#producto_update'
  post  'marcas/:id/vincular', :to => 'marcas#vincular', :as => 'marca_vincular_producto'
  post  'marcas/actualizar_orden', :to => 'marcas#actualizar_orden'

  get   'categoria(/:categoria)', :to => 'categorias#ver', :as => 'categoria_ver'  

  get   'producto(/:producto)', :to => 'productos#ver', :as => 'producto_ver'

  scope :path_names => { :new => 'registrar', :edit => 'editar' } do
    resources :productos
    resources :marcas
    resources :categorias
    resources :secciones
  end

  # última línea, hace match con el resto de las rutas y muestra 404
  match  '*a', :to => 'paginas#error_404'
end
