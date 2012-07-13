class PaginasController < ApplicationController
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
end
