class PaginasController < ApplicationController
  def home
    @bestsellers = Seccion.seccion_actual(Seccion.by_slug(:bestsellers))
    @lonuevo = Seccion.seccion_actual(Seccion.by_slug(:lonuevo))
    @seccion = Seccion.includes(:productos).by_slug('hotnow')
    @contenido = Seccion.seccion_actual(@seccion)
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
    cat = [64, 62, 63, 39]
    @productos = Producto.padres.publicados.rangodeprecios(params[:rango]).where(:categoria_id => cat).order(preciorder(params[:precio])).page(params[:page]).per(perparams(params[:ver]))
    @productoscount = Producto.padres.publicados.rangodeprecios(params[:rango]).where(:categoria_id => cat).count
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
end
