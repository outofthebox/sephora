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
end
