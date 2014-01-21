Sephora::Application.routes.draw do
  devise_for :mobileusers, :path => "mobile"

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

  get   ':seccion', :to => 'secciones#ver', :constraints => { :seccion => /allure2013|lanzamientosfall|backtoschool|potencializahighlights|fraganciasparael|skincareparael|narsblushes|obsessionsbeautybloggers|hotnow|bestsellers|bbcreams|tintedmoisturizers|sephorabath|probrushes|beautyobsessions|vacaciones|ouidad|esteelaudernails|bronzers|clasicosdeskincare|mascaras2013|aceitesskincareagosto2013|mascarillas|cccreams2013|skincarehighlightsoctubre|maquillajebijoux|rollerballs|fragancias30ml|fraganciasholiday|showergelphilosphy|skincareholiday|cofresholiday|obsesionesskincare|arielcollection|beautysteals/ }
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
  get '/exportcsv',:to => 'utilidades#exportcsv'
  
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
    resources :userwishes
  end

  get '/consultorpersonalbelleza', :to => 'paginas#consultores', :as => 'consultores'

  #ANIVERSARIO
  get '365'    => 'paginas#aniversario', :as => :aniversario
  #get 'beautyissue'    => 'paginas#aniversario', :as => :aniversario
  get 'beautyissue/tienda/:tienda'    => 'paginas#aniversario', :as => :aniversario_tienda
  get 'beautyissue/tienda/:tienda/fecha/:fecha'    => 'paginas#aniversario', :as => :aniversario_tienda_fecha

  get '365dias/eventos'    => 'paginas#aniversario_eventos', :as => :aniversario_eventos

  get '365dias/evento/nuevo'    => 'paginas#aniversario_evento_nuevo', :as => :aniversario_evento_nuevo
  post '365dias/evento/nuevo'    => 'paginas#aniversario_evento_nuevo_post', :as => :aniversario_evento_nuevo

  get '365dias/evento/:id/editar'    => 'paginas#aniversario_evento_editar', :as => :aniversario_evento_editar
  put '365dias/evento/:id/editar'    => 'paginas#aniversario_evento_editar_post', :as => :aniversario_evento_editar

  get '365dias/terminos-y-condiciones'  => 'paginas#aniversario_terminos', :as => 'aniversario_terminos'

  get 'sephoragifts' => 'paginas#sephoragifts'

  #MARCJACOBS
  get "marc-jacobs-beauty/home", :to => "marcjacobs#home", :as => 'marcjacobs'
  get "marc-jacobs-beauty/", :to => "marcjacobs#intro", :as => 'marc_intro'
  get "marc-jacobs-beauty/ojos", :to => "marcjacobs#ojos", :as => 'marc_ojos'
  get "marc-jacobs-beauty/labios", :to => "marcjacobs#labios", :as => 'marc_labios'
  get "marc-jacobs-beauty/unas", :to => "marcjacobs#unas", :as => 'marc_unas'
  get "marc-jacobs-beauty/rostro", :to => "marcjacobs#rostro", :as => 'marc_rostro'
  get "marc-jacobs-beauty/favoritos", :to => "marcjacobs#favoritos", :as => 'marc_favs'
  get "marc-jacobs-beauty/look", :to => "marcjacobs#look", :as => 'marc_look'
  get "marc-jacobs-beauty/catalogo", :to => "marcjacobs#catalogo", :as => 'marc_catalogo'

  #mobile
  get 'mobile', :to => 'mobile#home', :as => 'm_home'
  get 'mobile/favoritos', :to => 'mobile#favoritos', :as => 'm_favoritos'
  get 'mobile/cosmetiquera', :to => 'mobile#cosmetiquera', :as => 'm_cosmetiquera'
  get 'mobile/busqueda', :to => 'mobile#mobileilbusqueda', :as => 'm_busqueda'
  get 'mobile/producto/:slug', :to => 'mobile#mobileproducto', :as => 'm_producto'
  get 'mobile/login', :to => 'mobile#login', :as => 'm_login'
  get 'mobile/especiales', :to => 'mobile#especialesmes', :as => 'm_especiales'
  get 'mobile/beauty', :to => 'mobile#beauty', :as => 'm_beauty'
  get 'mobile/tiendas', :to => 'mobile#tiendas', :as => 'm_tiendas'
  get 'mobile/nuevo', :to => 'mobile#lonuevo', :as => 'm_nuevo'
  get 'mobile/hotnow/:seccion', :to => 'mobile#jotnao', :as => 'm_hotnow'
  get 'mobile/video', :to => 'mobile#video', :as => 'm_video'
  get 'mobile/legal', :to => 'mobile#legales', :as => 'm_legal'
  get 'mobile/favorite/:id', :to => 'mobile#favorite', :as => 'favoritear'
  get 'mobile/wallpapers', :to => 'mobile#wallpapers', :as => 'm_wallpaper'
  

  #wishlist
  get "wishlist", :to => 'wishlist#index', :as => "wishlist"
  post "wishlist", :to => 'wishlist#index', :as => "wishlist"

  get "wishlist/admin/", :to => 'wishlist#admin', :as => "wishlist_admin"
  post "wishlist/admin/", :to => 'wishlist#admin', :as => "wishlist_admin"

  get "wishlist/lista/", :to => 'wishlist#lista', :as => "wishlist_lista"
  post "wishlist/lista/", :to => 'wishlist#lista', :as => "wishlist_lista"

  
  get "wishlist/nuevo/(:uid)/(:post_id)/(:producto1)/(:producto2)/(:producto3)/(:producto4)/(:producto5)/(:token)", :to => "wishlist#nuevo", :as => "wishlist_nuevo"
  post "wishlist/nuevo/(:uid)/(:post_id)/(:producto1)/(:producto2)/(:producto3)/(:producto4)/(:producto5)/(:token)", :to => "wishlist#nuevo", :as => "wishlist_nuevo"
  
  get "wishlist/ver/(:uid)", :to => "wishlist#ver", :as => "wishlist_ver"
  post "wishlist/ver/(:uid)", :to => "wishlist#ver", :as => "wishlist_ver"

  get "wishlist/error", :to => 'wishlist#index', :as => "wishlist_error"
  post "wishlist/error", :to => 'wishlist#index', :as => "wishlist_error"

  get "wishlist/mi_lista/(:uid)/(:token)", :to => 'wishlist#user', :as => "wishlist_user"
  post "wishlist/mi_lista/(:uid)/(:token)", :to => 'wishlist#user', :as => "wishlist_user"

  #admin
  get "/admin/clear", :to => "application#clear_cache", :as => "clear_cache"


  #instaCosas
  get "instagram", :to => 'instagram#index', :as => "insta_sephora"
  post "instagram", :to => 'instagram#index', :as => "insta_sephora"
  post "instagram/suscribir", :to => 'instagram#new_stuff', :as => "insta_sephora_new"
  get "instagram/suscribir", :to => 'instagram#suscribir', :as => "insta_sephora_new"


  #Comunicados
  get   'comunicado', :to => 'paginas#comunicado', :as => 'comunicado'

  #sephora_tips
  get "sephora_tips", :to => 'sephora_tips#index', :as => "sephora_tips"
  post "sephora_tips", :to => 'sephora_tips#index', :as => "sephora_tips"
  post 'sephora_tips/send', :to => 'sephora_tips#post_tip', :as => 'post_sephora_tips'

  get "sephora_tips/admin/", :to => 'sephora_tips#admin', :as => "sephora_tips_admin"
  get "sephora_tips/admin/download", :to => 'sephora_tips#download', :as => "sephora_tips_download"
  
  #blog
  resources :posts
  get 'posts/tags/:tag', :to => 'blog#index', :as => 'tag'
  post '/posts/:id/comment', :to => 'posts#comment', :as => 'comment_post'
  post 'posts/:id/ranking', :to => 'posts#ranking', :as => 'ranking_post'

  # última línea, hace match con el resto de las rutas y muestra 404
  match  '*a', :to => 'paginas#error_404'
end
