Sephora::Application.routes.draw do
  
  #Usuarios
  devise_for :usuarios, controllers: {
    sessions: "usuarios/sessions",
    registrations: "usuarios/registrations",
    confirmations: "usuarios/confirmations",
    passwords: "usuarios/passwords",
    unlocks: "usuarios/unlocks"
  }
  
  get   'usuarios/lista', :to => 'usuarios#lista', :as => 'usuarios_lista'
  put   'usuario/actualizar/:id', :to => 'usuarios#actualizar', :as => 'usuario_actualizar'
  get   'usuario/usar_sesion/:id', :to => 'usuarios#usar_sesion', :as => 'usuario_usar_sesion'
  get   'logout(/:hash)', :to => 'usuarios#logout', :as => 'logout'
  get   'usuario/perfil', :to => "usuarios#perfil", :as => "usuario"
  get   'usuario/wishlist', :to => "usuarios#wishlist", :as => "usuario_wishlist"
  get   'usuario/bienvenido', :to => "usuarios#bienvenido", :as => "usuario_bienvenido"
  get   'usuario/wishlist/ver/:slug', :to => "usuarios#wishlist_ver", :as => "usuario_wishlist_ver"
  post  'usuario/wishlist/add/:upc', :to => "usuarios#wishlist_add", :as => "usuario_wishlist_add"
  post  'usuario/wishlist/del/:upc', :to => "usuarios#wishlist_del", :as => "usuario_wishlist_del"

  #mobile
  scope path: :mobile, as: "m" do
    match "/", :to => 'mobile#home', :as => 'home'
    match "download", :to => "mobile#download", :as => "download"

    #marcas
    match "/marcas", :to => 'mobile/marcas#index', :as => 'marcas'
    resources :marca, controller: 'mobile/marcas', :except => [:index]
    scope path: :marca, :as => "marca" do
    end

    match "/eventos", :to => 'mobile/eventos#index', :as => 'eventos'
    resources :evento, controller: 'mobile/eventos', :except => [:index]
    scope path: :evento, :as => "evento" do
    end

    match "/tiendas", :to => 'mobile/tiendas#index', :as => 'tiendas'
    resources :tienda, controller: 'mobile/tiendas', :except => [:index]
    scope path: :tienda, :as => "tienda" do
    end

    match "/minimakeovers", :to => 'mobile/minimakeovers#index', :as => 'minimakeovers'
    resources :minimakeover, controller: 'mobile/minimakeovers', :except => [:index]
    scope path: :minimakeover, :as => "minimakeover" do
    end

    match "/posts", :to => 'mobile/posts#index', :as => 'posts'
    resources :post, controller: 'mobile/posts', :except => [:index]
    scope path: :post, :as => "post" do
    end

    match "/soluciones", :to => 'mobile/soluciones#index', :as => 'soluciones'
    resources :solucion, controller: 'mobile/soluciones', :except => [:index]
    scope path: :solucion, :as => "solucion" do
    end
    

    match "/productos", :to => 'mobile/productos#index', :as => 'productos'
    resources :producto, controller: 'mobile/productos', :except => [:index]
    scope path: :producto, :as => "producto" do
    end

    match "/hotnow", :to => "mobile/productos#hotnow", :as => "hotnow"
    match "/bestsellers", :to => "mobile/productos#bestsellers", :as => "bestsellers"
    match "/lonuevo", :to => "mobile/productos#lonuevo", :as => "lonuevo"
    match "/favoritos", :to => "mobile/productos#favoritos", :as => "favoritos"

    match "/specials", :to => 'mobile/specials#index', :as => 'specials'
    scope path: :special, :as => "special" do
      match "/wallpapers", :to => "mobile/specials#wallpapers", :as => "wallpapers"
    end

      #Usuarios
    devise_for :usuarios, controllers: {
      sessions: "usuarios/sessions",
      registrations: "usuarios/registrations",
      confirmations: "usuarios/confirmations",
      passwords: "usuarios/passwords",
      unlocks: "usuarios/unlocks"
    }

    match "/usuarios", :to => 'mobile/usuarios#index', :as => 'usuarios'
    scope path: :usuario, :as => "usuario" do
      match 'logout(/:hash)', :to => 'mobile/usuarios#logout', :as => 'logout'
      match '/perfil', :to => "mobile/usuarios#perfil", :as => "perfil"
      match '/wishlist', :to => "mobile/usuarios#wishlist", :as => "wishlist"
      match '/bienvenido', :to => "mobile/usuarios#bienvenido", :as => "bienvenido"
    end


    match "/categorias", :to => 'mobile/categorias#index', :as => 'categorias'
    resources :categoria, controller: 'mobile/categorias', :except => [:index]
    scope path: :categoria, :as => "categoria" do
    end


  end


  root :to => 'paginas#home'

  resources :eventotiendas
  resources :tiendas

  # ---
  get "/pup_file", :to => "utilidades#pup_file", :as => "pup_file"
  # ---

  get '/colorful', :to => 'paginas#colorful', :as => 'colorful'
  get '/colorful/auth', :to => 'paginas#auth_please', :as => 'auth_please'
  post '/colorful/auth', :to => 'paginas#auth_please_post', :as => 'auth_please_post'
  get '/colorful/:personalidad', :to => 'paginas#colorful_show', :as => 'colorful_show'

  post 'registro', :to => 'paginas#registro', :as => 'registro'

  get 'registro/qr', :to => 'paginas#registro_qr', :as => 'registro_qr'
  post 'registro/qr/reg', :to => 'paginas#registro_qr_reg', :as => 'registro_qr_reg'

  get 'buscare', :to => 'utilidades#search', :as => 'buscare'

  get   ':seccion', :to => 'secciones#ver', :constraints => { :seccion => /allure2013|lanzamientosfall|backtoschool|potencializahighlights|fraganciasparael|skincareparael|narsblushes|obsessionsbeautybloggers|hotnow|bestsellers|bbcreams|tintedmoisturizers|sephorabath|probrushes|beautyobsessions|vacaciones|ouidad|esteelaudernails|bronzers|clasicosdeskincare|mascaras2013|aceitesskincareagosto2013|mascarillas|cccreams2013|skincarehighlightsoctubre|maquillajebijoux|rollerballs|fragancias30ml|fraganciasholiday|showergelphilosphy|skincareholiday|cofresholiday|obsesionesskincare|arielcollection|beautysteals|fraganciassanvalentin|mascaras|orquidearadiante|recien-desempacados|detalles-sets|fragancias|labios|divacarioca|lanzamientossummer|productospromocion|skincare|styling|herramientastop|skincareojos|holiday2014|paletasholiday|sets|coloroftheyear|skincarelabios/ }

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

  get   'importar(/:quoi)', :to => 'utilidades#importar'
  get   'importarimg', :to => 'utilidades#importarimg'
  get   'imgmover', :to => 'utilidades#imgmover'
  get   'parsearparents', :to => 'utilidades#parsearparents'

  get   'actprecios', :to => 'utilidades#actprecios'
  post  'actprecios', :to => 'utilidades#actprecios'
  get   'actprecios_save', :to => 'utilidades#actprecios_guardar', :as => 'actprecios_guardar'
  post  'actprecios_save', :to => 'utilidades#actprecios_guardar', :as => 'actprecios_guardar'


  get   'descontinuar', :to => 'utilidades#descontinuar'
  post  'descontinuar', :to => 'utilidades#descontinuar'
  get   'descontinuar_save', :to => 'utilidades#descontinuar_guardar', :as => 'descontinuar_guardar'
  post  'descontinuar_save', :to => 'utilidades#descontinuar_guardar', :as => 'descontinuar_guardar'

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

  # [--- MARCAS ---]
  get   "marcas/download(:pass)", :to => "marcas#export_to_csv", :as => "marcas_to_csv"
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

  get   'politicas-de-privacidad', :to => 'paginas#politicas', :as => 'politicas'

  get   "categorias/download(:pass)", :to => "categorias#export_to_csv", :as => "categorias_to_csv"
  get   'categorias/:id/desvincular/:categoria_producto/:hash', :to => 'categorias#desvincular', :as => 'categoria_desvincular_producto'
  get   'categorias/:id/vincular/:v_id/editar', :to => 'categorias#producto_editar', :as => 'categoria_editar_producto'
  put   'categorias/:id/vincular/:v_id/editar', :to => 'categorias#producto_update'
  post  'categorias/:id/vincular', :to => 'categorias#vincular', :as => 'categoria_vincular_producto'
  post  'categorias/actualizar_orden', :to => 'categorias#actualizar_orden'
  get   'categoria(/:categoria)', :to => 'categorias#ver', :as => 'categoria_ver'
  get   'rebajas', :to => 'promociones#show', :as => 'promociones_show'
  get   'rebajas/(:categoria)', :to => 'promociones#show', :as => 'promociones_show'


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

  get '/consultapersonalizadabelleza', :to => 'paginas#consultores', :as => 'consultores'
  get '/minimakeovers', :to => 'paginas#servicio_express', :as => 'servicioexpress'
  get '/makeoverpersonalizado', :to => 'paginas#servicios_completos', :as => 'servicioscompletos'
  get '/lista_eventos', :to => 'paginas#lista_eventos', :as => 'eventos'
  get '/beautyunoauno', :to => 'paginas#beauty', :as => 'beautyunoauno'

  #ANIVERSARIO
  get '365'    => 'paginas#aniversario', :as => :aniversario
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



  #tabs
  get "tabs/sephoragifts", :to => "tabs#sephoragifts", :as => "sephoragifts"
  post "tabs/sephoragifts", :to => "tabs#sephoragifts", :as => "sephoragifts"


  #blog
  resources :posts
  get 'posts/tags/:tag', :to => 'blog#index', :as => 'tag'
  post '/posts/:id/comment', :to => 'posts#comment', :as => 'comment_post'
  post 'posts/:id/ranking', :to => 'posts#ranking', :as => 'ranking_post'



  resources :landings
  resources :events, controller: "administracion/events", except: :index
  resources :store_events, controller: "administracion/store_events", except: :index
  scope path: :administracion, as: "admin" do
    resources :landings, except: :index
    resources :events, except: :index, controller: "administracion/events"
    resources :store_events, except: :index, controller: "administracion/store_events"
    match 'landings', to: 'administracion#landings', via: :get
    match 'events', to: 'administracion#events', via: :get
    match 'store_events', to: 'administracion#store_events', via: :get
  end

  scope path: :retomakeover, as: "aniversario_catorce" do
    match "/", to: "aniversario_catorce#index", :via => :get
    match "makeovers", to: "aniversario_catorce#makeovers", :via => :get
    match "big_prices", to: "aniversario_catorce#big_prices", :via => :get
    match "event_map", to: "aniversario_catorce#event_map", :via => :get
    match "teaser", to: "aniversario_catorce#teaser", :via => :get, :as => "teaser"
    match "vip", to: "aniversario_catorce#vip_entrance", :via => :get, :as => "vip"
    match "vip", to: "aniversario_catorce#vip_signin", :via => :post, :as => "vip_signin"


    match "ver/:marca", to: "aniversario_catorce#ver_marca", :via => :get, :as => "ver"
    scope path: :beauty_trip, as: "beauty_trip" do
      match "/", to: "aniversario_catorce#beauty_trip", :via => :get
      match "init", to: "aniversario_catorce#trivia_init", :via => :post, :as => "init"
      match "start", to: "aniversario_catorce#trivia_start", :via => :get, :as => "start"
      match "finish", to: "aniversario_catorce#trivia_finish", :via => :post, :as => "finish"
      match "salvada", to: "aniversario_catorce#trivia_salvada", :via => :get, :as => "salvada"
      match "gracias", to: "aniversario_catorce#trivia_gracias", :via => :get, :as => "gracias"
      match "participantes", to: "aniversario_catorce#trivia_participantes", :via => :get, :as => "participantes"
    end
  end


  #brand-minisite
  get 'sephora-collection/', :to => 'sephora_collection#index', :as => 'sephora_collection_index'
  get 'sephora-collection/seccion/:interna', :to => 'sephora_collection#interna', :as => 'sephora_collection_interna'
  get 'sephora-collection/rouge-land', :to => 'sephora_collection#rouge_land', :as => 'sephora_collection_rouge_land'
  get 'sephora-collection/foundation-land', :to => 'sephora_collection#foundation_land', :as => 'sephora_collection_foundation_land'
  get 'sephora-collection/outrageus-land', :to => 'sephora_collection#outrageus_land', :as => 'sephora_collection_outrageus_land'
  get 'sephora-collection/promociones', :to => 'sephora_collection#promociones', :as => 'sephora_collection_promociones'

  # ajax call
  get "sephora-collection/squares/:interna", :to => 'sephora_collection#load_squares', :as => "sephora_collection_loadsquares"

  
  # friends and family
  get 'friendsandfamily/', :to => 'friendsandfamily#index', :as => 'friendsandfamily_index'
  post 'friendsandfamily/code', :to => 'friendsandfamily#code', :as => 'friendsandfamily_code'
  get 'friendsandfamily/gracias/:id', :to => 'friendsandfamily#gracias', :as => 'friendsandfamily_gracias'
  get 'friendsandfamily/ya_descargaste', :to => 'friendsandfamily#ya_descargaste', :as => 'friendsandfamily_ya_descargaste'
  get 'friendsandfamily/delete_cookie', :to => 'friendsandfamily#delete_cookie', :as => 'friendsandfamily_delete_cookie'


  #sitemap
  get 'sitemap.xml', :to => 'sitemap#index', :defaults => { :format => 'xml' }
  # última línea, hace match con el resto de las rutas y muestra 404
  match  '*a', :to => 'paginas#error_404'
end


