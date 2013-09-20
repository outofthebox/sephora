class PaginasController < ApplicationController
  before_filter :auth, :only => [:colorful, :colorful_show] if ENV['color_activo'] == '0'
  def home
    @bestsellers = Seccion.seccion_actual(Seccion.by_slug(:bestsellers))
    @lonuevo = Seccion.seccion_actual(Seccion.by_slug(:lonuevo))
    @seccion = Seccion.includes(:productos).by_slug('hotnow')
    @contenido = Seccion.seccion_actual(@seccion)
    @registro = Registro.new
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
    render :file => "error/404", :status => 404
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
  def bloggers
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

  private
  def auth
    if session[:colorful] == ENV['colorful']
      true
    else
      redirect_to auth_please_path
    end
  end
end
