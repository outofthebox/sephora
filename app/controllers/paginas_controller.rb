# encoding: UTF-8
class PaginasController < ApplicationController
  before_filter :auth, :only => [:colorful, :colorful_show] if ENV['color_activo'] == '0'

  def home
    @bestsellers = Seccion.seccion_actual(Seccion.by_slug(:sephorapicks))
    @lonuevo = Seccion.seccion_actual(Seccion.by_slug(:lonuevo))
    @seccion = Seccion.includes(:productos).by_slug('hotnow')
    @contenido = Seccion.seccion_actual(@seccion)
    @registro = Registro.new
    @banners = Banner.in_range.prioritise
    @minis = {izq: Banner.get_mini_izquierdo, der: Banner.get_mini_derecho}

    @careoca_makeup = Producto.where(:upc => ["3378872080497","3378872080473", "3378872080572","3378872080442"])
    @careoca_bath = Producto.where(:upc => ["3378872079781", "3378872079743", "3378872079750", "3378872079767", "3378872079736"])
  end

  def beautyfair; end
  def masterclass; end
  def opening; end
  def oasis; end
  def brow_collection; end
  def celebra_con_nosotros; end
  def promocionessephora; end
  def regalaconamor; end


  def mascarillasingredientesnaturales; end
  def beneficiosmascarillas
    @hidratacion = Producto.where(:upc => ["809280009037","809280011887","809280113369","809280113352","809280120015","809280126741","809280126307"])
    @antiedad = Producto.where(:upc => ["3522930001379","3522930001386","3522930001621","3522930001775","809280101526","809280120381","809280122057","809280117992","809280116261"])
    @control = Producto.where(:upc => ["851939002821","851939002838","852575005696","809280113376","809280126468","3522930001102","3522930001812"])
    @firmeza = Producto.where(upc: ["3522930001881","3522930001874","3522930001911","3522930001898","809280122163","809280123764","809280126802"])
    @reduccion = Producto.where(upc: ["808144250011","808144270019","808144251018","808144260218","808144271009","808144272006","819002010302","819002010432","819002014300"])
    @luminosidad = Producto.where(upc: ["687795803018","687795389017","687795432010","687795594008","687795606008","670367010365","670367010426","670367011867","670367001011"])
  end



  def get_new_search
    @search_cats = []; 
    
    @search_marcas =  Marca.con_productos
    @search_categorias =  Categoria.all
    @search_productos =  Producto.publicados

    @search_marcas.each do |m| @search_cats << {label: m.marca, category: "Marcas", link: marca_ver_path(m.slug)} end
    @search_categorias.each do |c| @search_cats << {label: c.nombre, category: "Categorias", link: categoria_ver_path(c.slug)} end
    @search_productos.each do |p| @search_cats << {label: p.nombre, category: "Productos", link: producto_ver_path(p.slug)} end

    render json: @search_cats.to_json
  end

  def lista_eventos
    #m = [78, 93, 75, 92, 79, 77, 76, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91]
    #n = m & Event.where({id: m}).pluck(:id)
    #@eventos = Event.where({id: n}).index_by(&:id).values_at(*n) rescue []
    @eventos = Event.all
    @tiendas = Tienda.all
  end

  def registro
    @registro = Registro.new params[:registro]
    if @registro.save
      h = Hominid::API.new(ENV['MAILCHIMP_API'], {:secure => true, :timeout => 60})
      unless h.list_subscribe(ENV['MAILCHIMP_LIST_ID'], params[:registro][:email], {'FNAME' => params[:registro][:nombre] || '', 'LNAME' => params[:registro][:apellido] || '', 'CP' => params[:registro][:cp] || ''}, 'html', true, true, true, true).nil?
        flash[:registro] = true
      end
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def registro_qr
    @registro_qr = Registro.new
    render :layout => 'mobile'
  end

  def registro_qr_reg
    @registro_qr = Registro.new params[:registro]
    @registro_qr.qr = true
    if @registro_qr.save
      h = Hominid::API.new(ENV['MAILCHIMP_API'], {:secure => true, :timeout => 60})
      unless h.list_subscribe(ENV['MAILCHIMP_LIST_ID'], params[:registro][:email], {'FNAME' => params[:registro][:nombre] || '', 'LNAME' => params[:registro][:apellido] || '', 'CP' => params[:registro][:cp] || '', 'MMERGE11' => params[:registro][:tienda] || '', 'MMERGE12' => 'QR'}, 'html', true, true, true, true).nil?
        flash[:reg] = true
      end
      redirect_to registro_qr_path
    else
      redirect_to registro_qr_path
    end
  end

  def contacto
    @contacto = Contacto.new
  end

  def contacto_post
    @contacto = Contacto.new params[:contacto]
    if @contacto.valid?
      ContactoMailer.contacto(params[:contacto][:email], params[:contacto][:mensaje]).deliver
      flash[:contacto_exito] = true
      redirect_to contacto_path
    else
      render :contacto
    end
  end

  def tiendas

  end

  def obsequios
    cat = [41, 50, 64, 62, 63, 39]
    @productos = Producto.padres.rangodeprecios(params[:rango]).where(:categoria_id => cat, :publicado => true).order(preciorder(params[:precio])).page(params[:page]).per(perparams(params[:ver]))
    @productoscount = Producto.padres.rangodeprecios(params[:rango]).where(:categoria_id => cat, :publicado => true).count
  end

  def suscripcion
    @suscripcion = Suscripcion.new
  end

  def suscripcion_post
    @suscripcion = Suscripcion.new params[:suscripcion]
    if @suscripcion.valid?
      h = Hominid::API.new(ENV['MAILCHIMP_API'], {:secure => true, :timeout => 60})
      unless h.list_subscribe(ENV['MAILCHIMP_LIST_ID'], params[:suscripcion][:email], {'FNAME' => params[:suscripcion][:nombre] || '', 'LNAME' => params[:suscripcion][:apellido] || '', 'CP' => params[:suscripcion][:codigo] || ''}, 'html', true, true, true, true).nil?
        flash[:suscripcion_exito] = "Gracias por suscribirte"
      end
      redirect_to "/suscripcion"
    else
      render :suscripcion
    end
  end

  def error_404
    render :file => "error/404", :status  => 200
  end

  #ANIVERSARIO

  def aniversario
    @eventos = Evento.filtro(params[:tienda])
    @eventos_fecha = Evento.filtro(params[:tienda], params[:fecha]) unless params[:fecha].nil?
    render :layout => 'aniversario'
  end

  def fbapp
    render :layout => 'aniversario'
  end

  def aniversario_eventos
    @eventos = Evento.all
  end

  def aniversario_evento_nuevo
    @evento = Evento.new
    @evento.fecha = Date.today
  end

  def aniversario_evento_nuevo_post
    @evento = Evento.create params[:evento]
    if @evento.valid?
      @evento.save
      redirect_to aniversario_evento_nuevo_path
    else
      render :aniversario_evento_nuevo
    end
  end

  def aniversario_evento_editar
    @evento = Evento.find params[:id]
    @evento.fecha = @evento.fecha.strftime('%F')
  end

  def aniversario_evento_editar_post
    @evento = Evento.find params[:id]
    @evento.update_attributes params[:evento]
    if @evento.valid?
      @evento.save
      redirect_to aniversario_evento_nuevo_path
    else
      render :aniversario_evento_editar
    end
  end

  def aniversario_terminos
    render :layout => 'aniversario'
  end
  def holiday

  end
  def download

  end
  def wallpapers
    @wallpaper = Wallpaper.new
  end
  def wallpaperssend
    @wallpaper = Wallpaper.new params[:wallpaper]
    imagen = params[:wallpaper][:imagen]
    mail = params[:wallpaper][:email]
    if @wallpaper.valid?
      WallpaperMailer.enviarmail(imagen, mail).deliver
      flash[:exito] = true
      render :wallpapers
    else
      flash[:error] = true
      render :wallpapers
    end
  end
  def comunicado
  end
  def bloggers
  end
  
  def favoritoslabios
    @lipsticks = Producto.where(:upc => ["811999020074", "818015018770", "3378872063827", "3378872044222", "3346470417199", "887167016583", "604214272804", "877231002109", "607710005396", "3548752047098", "607845094609"])
    @lipglosses = Producto.where(:upc => ["3348901130660", "3348901207355", "604214921351", "818015012693", "3378872057819", "3378872050391", "3605533008928", "3365440714373", "98132300419", "602004043610", "607845016717", "736150066503"])
    @lipstains = Producto.where(:upc => ["3548752057486", "877231001447", "3378872079101", "3378872081807", "94800341777", "651986501533", "607710038943", "3365440737969", "602004070432"])
    @perfectred = Producto.where(:upc => ["3378872044246", "094800341807", "877231001478", "811999020241", "604214271906", "887167016620", "607845010050", "3548752047166", "607710005310"])
  end

  def favoritosmascarillas
    @hidratantes = Producto.where(:upc => ["809280009037", "3378872082286", "713757240833", "736211449719", "808144215010", "670367404058"])
    @antiedad = Producto.where(:upc => ["809280101526", "3378872082309", "670367000540", "670367001653", "651043024517", "651473531807"])
    @multibeneficios = Producto.where(:upc => ["651043021523", "670367001257", "713757241830", "736211224262", "808144250011", "808144350018"])
    @denoche = Producto.where(:upc => ["808144222018", "020714576219", "670367011867"])
  end

  def sephoragifts
    render :layout => 'clean'
  end
  def colorvision
  end
  def consultor
  end
  def colorful
    render :layout => 'colorful'
  end
  def colorful_show
    @datass = params[:personalidad]
    prods = case @datass
      when "hipster" then [8272, 8275, 8276, 8277, 8278, 8279, 8280, 8281, 8282, 8285, 8286, 8287, 8290, 8291, 8292, 8293, 8298, 8299, 8300, 8302, 8303, 8306, 8312, 8319, 8323, 8324, 8327, 8331]
      when "chic" then [8273, 8274, 8285, 8296, 8297, 8298, 8301, 8302, 8304, 8306, 8307, 8308, 8309, 8310, 8311, 8313, 8314, 8318, 8319, 8320, 8321, 8323, 8324, 8325, 8328, 8329, 8330, 8331]
      when "junkie" then [8272, 8274, 8275, 8276, 8277, 8278, 8279, 8280, 8281, 8282, 8283, 8285, 8286, 8287, 8290, 8291, 8292, 8293, 8298, 8299, 8300, 8302, 8303, 8306, 8312, 8313, 8314, 8319, 8322, 8323, 8324, 8327]
      when "rocker" then [8273, 8284, 8288, 8289, 8294, 8295, 8302, 8303, 8305, 8307, 8308, 8309, 8313, 8314, 8315, 8316, 8317, 8318, 8320, 8324, 8326]
      else nil
    end
    @productos = Producto.find(prods)
    @principal = Producto.find(8272).slug
    render :layout => 'colorful'
  end

  def auth_please
    render :layout => 'colorful'
  end
  def auth_please_post
    pass = params[:auth][:password]
    if pass == ENV['colorful']
      session[:colorful] = ENV['colorful']
      redirect_to colorful_path
    else
      redirect_to auth_please_path
    end
  end

  # mascarillas
  def mascarillasnocturnas; end
  
  def mascarillashidratantes
    @face_mask = [{
      name:"Honey",
      link: "http://www.sephora.com.mx/producto/sleeping-mask-honey-3378872089827?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Sleeping",
      image: "masks/mask_party/Honey.png"
    },{
      name:"Lingzhi",
      link: "http://www.sephora.com.mx/producto/sleeping-mask-lingzhi-3378872089889?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Sleeping",
      image: "masks/mask_party/Lingzhi.png"
    },{
      name:"Pearl",
      link: "http://www.sephora.com.mx/producto/sleeping-mask-pearl-3378872089896?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Sleeping",
      image: "masks/mask_party/Pearl.png"
    },{
      name:"Ginseng",
      link: "http://www.sephora.com.mx/producto/sleeping-mask-ginseng-3378872089872?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Sleeping",
      image: "masks/mask_party/Ginseng.png"
    },{
      name:"Lotus",
      link: "http://www.sephora.com.mx/producto/sleeping-mask-lotus-3378872089841?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Sleeping",
      image: "masks/mask_party/Lotus.png"
    },{
      name:"Rose",
      link: "http://www.sephora.com.mx/producto/sleeping-mask-rose-3378872089858?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Sleeping",
      image: "masks/mask_party/Rose.png"
    },{
      name:"Green Tea Mask",
      link: "http://www.sephora.com.mx/producto/sleeping-mask-green-tea-3378872089865?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Sleeping",
      image: "masks/mask_party/Green.png"
    },{
      name:"Promegranate Mask",
      link: "http://www.sephora.com.mx/producto/sleeping-mask-pomegranate-3378872089834?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Sleeping",
      image: "masks/mask_party/Promegranate.png"
    }]
    render "mask_party"
  end
  def mascarillasantiedad
    @face_mask = [{
      name: "Honey",
      link: "http://www.sephora.com.mx/producto/face-mask-honey-3378872082255?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Face",
      image: "masks/mask_face/Honey.png"
    },{
      name: "Pearl",
      link: "http://www.sephora.com.mx/producto/face-mask-pearl-3378872082323?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Face",
      image: "masks/mask_face/Pearl.png"
    },{
      name: "Ginseng",
      link: "http://www.sephora.com.mx/producto/face-mask-ginseng-3378872082309?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Face",
      image: "masks/mask_face/Ginseng.png"
    },{
      name: "Green tea",
      link: "http://www.sephora.com.mx/producto/face-mask-green-tea-3378872082293?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Face",
      image: "masks/mask_face/Green.png"
    },{
      name: "Rose Mask",
      link: "http://www.sephora.com.mx/producto/face-mask-rose-3378872082286?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Face",
      image: "masks/mask_face/Rose.png"
    },{
      name: "Promegranate ",
      link: "http://www.sephora.com.mx/producto/face-mask-pomegranate-3378872082262?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Face",
      image: "masks/mask_face/Promegranate.png"
    },{
      name: "Lotus",
      link: "http://www.sephora.com.mx/producto/face-mask-lotus-3378872082279?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Face",
      image: "masks/mask_face/Lotus.png"
    },{
      name: "Lingzhi",
      link: "http://www.sephora.com.mx/producto/face-mask-lingzhi-3378872082316?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Face",
      image: "masks/mask_face/Lingzhi.png"
    }];
    render "mask_party"
  end
  def mascarillasmultibeneficio
    @face_mask = [{
      name: "Rose",
      link: "http://www.sephora.com.mx/producto/eye-mask-rose-3378872088882?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Eye",
      image: "masks/mask_eye/Rose.png"
    },{
      name: "Promegranate",
      link: "http://www.sephora.com.mx/producto/eye-mask-pomegranate-3378872088868?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Eye",
      image: "masks/mask_eye/Promegranate.png"
    },{
      name: "Ginseng",
      link: "http://www.sephora.com.mx/producto/eye-mask-ginseng-3378872088905?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Eye",
      image: "masks/mask_eye/Ginseng.png"
    },{
      name: "Lingzhi",
      link: "http://www.sephora.com.mx/producto/eye-mask-lingzhi-3378872088912?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Eye ",
      image: "masks/mask_eye/Lingzhi.png"
    },{
      name: "Lotus",
      link: "http://www.sephora.com.mx/producto/eye-mask-lotus-3378872088875?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Eye",
      image: "masks/mask_eye/Lotus.png"
    },{
      name: "Pearl",
      link: "http://www.sephora.com.mx/producto/eye-mask-pearl-3378872088929?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Eye",
      image: "masks/mask_eye/Pearl.png"
    },{
      name: "Honey",
      link: "http://www.sephora.com.mx/producto/eye-mask-honey-3378872088851?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Eye",
      image: "masks/mask_eye/Honey.png"
    },{
      name: "Green Tea",
      link: "http://www.sephora.com.mx/producto/eye-mask-green-tea-3378872088899?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Eye",
      image: "masks/mask_eye/Green.png"
    }];
    render "mask_party"
  end

  # miraclecushion
  def miraclecushion; end

  # atelier
  def collectionazur; end
  def collectionoriginale; end
  def collectionmatiere; end
  def collectionmetal; end

  # basecontorno
  def basecontorno
    render layout: 'contorno'
  end
  def basecontorno_foundation
    render layout: 'contorno'
  end
  def basecontorno_contour
    render layout: 'contorno'
  end
  def basecontorno_foundation_concern
    render layout: 'contorno'
  end
  def basecontorno_contour_concern
    render layout: 'contorno'
  end
  def basecontorno_foundation_video
    @data = {
      sensible: {
        upcs: ['3548752038584','3548752073271','736150129765','3378872067146','3378872067177','713757273701','3522930010180'],
        question: '¿Cuál es la manera más fácil y práctica de cubrir las imperfecciones como rojeces y manchas?',
        video: 'gSeA2slU-DA'
      },
      seca: {
        upcs: ['098132364329','098132368983','098132132096','3378872067139'],
        question: '¿Cuál es la textura recomendada y la técnica de aplicación para no incrementar las líneas o resecar la piel?',
        video: 'PhV1KSG3pgE'
      },
      mixta: {
        upcs: ['899930000828','3378872072713','3548752030601','3548752079068','3378872067177','3378872067146'],
        question: '¿Cuáles son los motivos por los cuales la base de maquillaje no dura?',
        video: 'aMvyPGsVOks'
      },
      grasa: {
        upcs: ['607710016606','818015012983','713757273701'],
        question: '¿Qué base de maquillaje es el ideal para el tipo de piel grasa o con poros?',
        video: 'rHUMCa4CRjc'
      }
    }
    result = @data[params[:tipo].to_sym]
    @productos = Producto.where(:upc => result[:upcs])
    @question = result[:question]
    @video = result[:video]
    render layout: 'contorno'
  end
  def basecontorno_contour_video
    @data = {
      corazon: {
        upcs: ['3548752083737','818015011832','879634001932','3378872075141','3378872067245','3378872067337','3378872067184','3522930010180','736150133502'],
        question: '¿Cuál es la técnica que debo utilizar para balancear mi rostro con forma de corazón?',
        video: 'ukcIFdaGjP4'
      },
      ovalado: {
        upcs: ['094800348776','3548752030601','713757273701','3378872067160','3378872067207','3378872067139','736150082909','3348901130738'],
        question: '¿Cuál es la técnica que debo utilizar para resaltar mis pómulos si mi rostro es ovalado?',
        video: 'd-0WzcYM5Iw'
      },
      cuadrado: {
        upcs: ['811999021200','877231000822','818015011917','818015010316','877231001942','3548752079068','811999021224','3378872067139','3378872067245'],
        question: '¿Cuál es la técnica que debo utilizar para suavizar mis ángulos de la mandíbula si mi rostro es cuadrado?',
        video: 'udIIsVqAloA'
      },
      redondo: {
        upcs: ['3378872085423','689304184601','3548752067355','713757273701','3548752043816','3548752079068','3378872067207'],
        question: '¿Cuál es la técnica que debo utilizar para crear ángulos  si mi rostro es redondo?',
        video: 'R90sdBbMGIw'
      }
    }
    result = @data[params[:tipo].to_sym]
    @productos = Producto.where(:upc => result[:upcs])
    @question = result[:question]
    @video = result[:video]
    render layout: 'contorno'
  end

  private
  def auth
    if session[:colorful] == ENV['colorful']
      true
    else
      redirect_to auth_please_path
    end
  end
end
