class SeccionesController < ApplicationController
  def index
    @secciones = Seccion.arrange
    authorize! :manage, @secciones
  end

  # hot now, favorites, best sellers
  def ver
    @seccion = Seccion.by_slug(params[:seccion]) rescue false
    if @seccion != false and !@seccion.nil?
      @contenido = Seccion.seccion_actual(@seccion)
    else
      slugs = {animation: [], campaings: []}

      slugs[:animation] = AnimationCarousel.all.map(&:slug)
      slugs[:campaings] = CampaingLanding.all.map(&:vanity_url)

      if slugs[:animation].include?(params[:seccion])
        redirect_to ver_carrusel_path(slug: params[:seccion])
      elsif slugs[:campaings].include?(params[:seccion])
        redirect_to ver_landing_path(slug: params[:seccion])
      else
        redirect_to root_path
      end
    end
  end

  def soluciones
    @seccion = Seccion.by_slug(:soluciones)
    @subsecciones = Seccion.subsecciones(@seccion)

    if params[:id] and (@solucion = Seccion.subsecciones(@seccion, params[:id]))
      render :solucion_ver
    end
  end

  def favorites
    @seccion = Seccion.by_slug(:sephorapicks)
    @subsecciones = Seccion.subsecciones(@seccion)
    @contenido = Seccion.seccion_actual(@seccion)
    if params[:id] and (@favorite = Seccion.subsecciones(@seccion, params[:id]))
      render :favorites_ver
    end
  end

  def show
    @seccion = Seccion.find params[:id]
    authorize! :manage, @seccion
  end

  def new
    @seccion = Seccion.new
    authorize! :manage, @seccion
  end

  def create
    @seccion = Seccion.create params[:seccion]
    authorize! :manage, @seccion
    if @seccion.valid?
      @seccion.save
      redirect_to new_seccion_path
    else
      render :new
    end
  end

  def edit
    @seccion = Seccion.includes(:productos).find params[:id]
    authorize! :manage, @seccion
  end

  def update
    @seccion = Seccion.find params[:id]
    authorize! :manage, @seccion
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
    authorize! :manage, seccion
    vinculo = seccion.producto_seccion.build params[:producto_seccion]
    if vinculo.valid?
      vinculo.save
    end
    redirect_to edit_seccion_path(seccion.id)
  end

  def desvincular
    seccion = Seccion.find params[:id]
    authorize! :manage, seccion
    producto_seccion = seccion.producto_seccion.find params[:producto_seccion]

    if check_minihash(producto_seccion, params[:hash])
      producto_seccion.destroy
    end

    redirect_to edit_seccion_path(seccion.id)
  end

  def producto_editar
    @seccion = Seccion.find params[:id]
    authorize! :manage, @seccion
    @producto_seccion = @seccion.producto_seccion.find params[:v_id]
  end

  def producto_update
    seccion = Seccion.find params[:id]
    authorize! :manage, seccion
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
    authorize! :manage, vinculos
    orden = (0...vinculos.size)

    ProductoSeccion.update( vinculos, orden.map{|o| { :orden => o }}).reject { |p| p.errors.empty? }

    render :text => orden.to_a
  end
  def feedback
    @feedback = Feedback.new
  end

  def feedback_save
    @feedback = Feedback.new params[:feedback]
    if @feedback.save
      redirect_to root_path
    else
      render :nuevo
    end
  end
end
