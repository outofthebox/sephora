class SeccionesController < ApplicationController
  def index
    @secciones = Seccion.arrange
  end

  def ver
    @seccion = Seccion.by_slug(params[:seccion])
    @contenido = Seccion.seccion_actual(@seccion)
  end

  def show
    @seccion = Seccion.find params[:id]
  end

  def new
    @seccion = Seccion.new
  end

  def create
    @seccion = Seccion.create params[:seccion]
    if @seccion.valid?
      @seccion.save
      redirect_to new_seccion_path
    else
      render :new
    end
  end

  def edit
    @seccion = Seccion.includes(:productos).find params[:id]
  end

  def update
    @seccion = Seccion.find params[:id]
    @seccion.update_attributes params[:seccion]
    if @seccion.valid?
      @seccion.save
      redirect_to edit_seccion_path(params[:id])
    else
      render :edit
    end
  end

  def destroy
  end

  # Vínculos

  def vincular
    seccion = Seccion.find params[:id]
    vinculo = seccion.producto_seccion.build params[:producto_seccion]
    if vinculo.valid?
      vinculo.save
    end
    redirect_to edit_seccion_path(seccion.id)
  end

  def desvincular
    seccion = Seccion.find params[:id]
    producto_seccion = seccion.producto_seccion.find params[:producto_seccion]

    if check_minihash(producto_seccion, params[:hash])
      producto_seccion.destroy
    end

    redirect_to edit_seccion_path(seccion.id)
  end

  def producto_editar
    @seccion = Seccion.find params[:id]
    @producto_seccion = @seccion.producto_seccion.find params[:v_id]
  end

  def producto_update
    seccion = Seccion.find params[:id]
    producto_seccion = seccion.producto_seccion.find(params[:v_id])
    producto_seccion.update_attributes params[:producto_seccion]
    if producto_seccion.valid?
      producto_seccion.save
      redirect_to seccion_editar_producto_path(seccion.id, producto_seccion.id)
    else
      render :producto_editar
    end
  end

  def actualizar_orden
    vinculos = params[:vinculo_id]
    orden = (0...vinculos.size)

    ProductoSeccion.update( vinculos, orden.map{|o| { :orden => o }}).reject { |p| p.errors.empty? }

    render :text => orden.to_a
  end

end
