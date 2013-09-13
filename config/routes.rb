Sephora::Application.routes.draw do
  resources :eventotiendas

  resources :tiendas

  devise_for :usuarios

  root :to => 'paginas#home'

  get '/colorful', :to => 'paginas#colorful', :as => 'colorful'
  get '/colorful/auth', :to => 'paginas#auth_please', :as => 'auth_please'
  post '/colorful/auth', :to => 'paginas#auth_please_post', :as => 'auth_please_post'
  get '/colorful/:personalidad', :to => 'paginas#colorful_show', :as => 'colorful_show'
  
  post 'registro', :to => 'paginas#registro', :as => 'registro'

  get 'registro/qr', :to => 'paginas#registro_qr', :as => 'registro_qr'
  post 'registro/qr/reg', :to => 'paginas#registro_qr_reg', :as => 'registro_qr_reg'

  get 'buscare', :to => 'utilidades#search', :as => 'buscare'

  get   ':seccion', :to => 'secciones#ver', :constraints => { :seccion => /lanzamientosfall|backtoschool|potencializahighlights|fraganciasparael|skincareparael|narsblushes|obsessionsbeautybloggers|hotnow|bestsellers|bbcreams|tintedmoisturizers|sephorabath|probrushes|beautyobsessions|vacaciones|ouidad|esteelaudernails|bronzers|clasicosdeskincare|mascaras2013|aceitesskincareagosto2013|mascarillas|cccreams2013/ }
  get   'soluciones(/:id)', :to => 'secciones#soluciones', :as => 'soluciones'
  get   'favorites(/:id)', :to => 'secciones#favorites', :as => 'favorites'
  get   'holiday', :to => 'paginas#holiday', :as => 'holiday'
  
  get   'holiday/wallpapers', :to => 'paginas#wallpapers', :as => 'wallpapers'
  post   'holiday/wallpapers', :to => 'paginas#wallpaperssend', :as => 'wallpaperssend'

  get   'colorvision', :to => 'paginas#colorvision', :as => 'colorvision'

  get   'beautybloggers', :to => 'paginas#bloggers', :as => 'bloggers'

  get   'busqueda', :to => 'productos#busqueda', :as => 'busqueda'

  get   'secciones/:id/desvincular/:producto_seccion/:hash', :to => 'secciones#desvincular', :as => 'seccion_desvincular_producto'
  get   'secciones/:id/vincular/:v_id/editar', :to => 'secciones#producto_editar', :as => 'seccion_editar_producto'
  put   'secciones/:id/vincular/:v_id/editar', :to => 'secciones#producto_update'
  post  'secciones/:id/vincular', :to => 'secciones#vincular', :as => 'seccion_vincular_producto'
  post  'secciones/actualizar_orden', :to => 'secciones#actualizar_orden'

  get   'feedback', :to => 'secciones#feedback', :as => 'feedbacks'
  post  'feedback', :to => 'secciones#feedback_save', :as => 'feedbacks'

  get   'usuarios/lista', :to => 'usuarios#lista', :as => 'usuarios_lista'
  put   'usuario/actualizar/:id', :to => 'usuarios#actualizar', :as => 'usuario_actualizar'
  get   'usuario/usar_sesion/:id', :to => 'usuarios#usar_sesion', :as => 'usuario_usar_sesion'
  get   'logout(/:hash)', :to => 'usuarios#logout', :as => 'logout'

  get   'importar(/:quoi)', :to => 'utilidades#importar'
  get   'importarimg', :to => 'utilidades#importarimg'
  get   'imgmover', :to => 'utilidades#imgmover'
  get   'parsearparents', :to => 'utilidades#parsearparents'
  get   'actprecios', :to => 'utilidades#actprecios'
  post  'actprecios', :to => 'utilidades#actprecios'
  get   'actprecios_save', :to => 'utilidades#actprecios_guardar', :as => 'actprecios_guardar'
  post  'actprecios_save', :to => 'utilidades#actprecios_guardar', :as => 'actprecios_guardar'
  get   'updateupc', :to => 'utilidades#update_upc'
  get   'improd', :to => 'utilidades#improd'
  get   'cambiarnombres', :to => 'utilidades#cambiarnombres'
  get   'actualizar', :to => 'utilidades#actualizar'
  get   'desc', :to => 'utilidades#desc'
  get   'cambiar_marcas', :to => 'utilidades#cambiar_marcas'
  get   'editar/:upc', :to => 'utilidades#editupc'
  
  get   'producto', :to => 'productos#index', :as => 'producto_index'
  get   'producto/:slug',  :to => 'productos#show', :as => 'producto_ver'
  get   'productos/busqueda', :to => 'productos#busqueda_old', :as => 'productos_busqueda'
  
  # get   'marca', :to => 'marcas#index'
  get   'marca/:slug',  :to => 'marcas#show', :as => 'marca_ver'

  get   'admin/productos', :to => 'productos#index_admin'

  get   'contacto', :to => 'paginas#contacto', :as => 'contacto'
  post  'contacto', :to => 'paginas#contacto_post'

  get   'tu-lista', :to => 'paginas#tulista'

  # get   'tiendas', :to => 'paginas#tiendas', :as => 'tiendas'
  get   'eventos', :to => 'paginas#eventos', :as => 'eventos'
  get   'obsequios', :to => 'paginas#obsequios', :as => 'obsequios'

  get   'suscripcion', :to => 'paginas#suscripcion', :as => 'suscripcion'
  post  'suscripcion', :to => 'paginas#suscripcion_post'

  get   'politicas-de-privacidad', :to => 'paginas#politicas', :as => 'politicas'

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

  get   'admin/actualizar_precios', :to => 'utilidades#actprecios', :as => 'admin_actprecios'

  scope :path_names => { :new => 'registrar', :edit => 'editar' } do
    resources :productos
    resources :marcas
    resources :categorias
    resources :secciones
  end

  get '/consultorpersonalbelleza', :to => 'paginas#consultores', :as => 'consultores'

  #ANIVERSARIO
  get '365'    => 'paginas#aniversario', :as => :aniversario
  get '365dias'    => 'paginas#aniversario', :as => :aniversario
  get '365dias/tienda/:tienda'    => 'paginas#aniversario', :as => :aniversario_tienda
  get '365dias/tienda/:tienda/fecha/:fecha'    => 'paginas#aniversario', :as => :aniversario_tienda_fecha

  get '365dias/eventos'    => 'paginas#aniversario_eventos', :as => :aniversario_eventos

  get '365dias/evento/nuevo'    => 'paginas#aniversario_evento_nuevo', :as => :aniversario_evento_nuevo
  post '365dias/evento/nuevo'    => 'paginas#aniversario_evento_nuevo_post', :as => :aniversario_evento_nuevo

  get '365dias/evento/:id/editar'    => 'paginas#aniversario_evento_editar', :as => :aniversario_evento_editar
  put '365dias/evento/:id/editar'    => 'paginas#aniversario_evento_editar_post', :as => :aniversario_evento_editar

  get '365dias/terminos-y-condiciones'  => 'paginas#aniversario_terminos', :as => 'aniversario_terminos'

  get 'sephoragifts' => 'paginas#sephoragifts'

  # última línea, hace match con el resto de las rutas y muestra 404
  match  '*a', :to => 'paginas#error_404'
end
