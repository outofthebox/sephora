class PaginasController < ApplicationController
  def home
    @bestsellers = Seccion.seccion_actual(Seccion.by_slug(:bestsellers))
    @lonuevo = Seccion.seccion_actual(Seccion.by_slug(:lonuevo))
    @seccion = Seccion.by_slug('hotnow')
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
end
