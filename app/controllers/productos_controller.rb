require 'riddle'
class ProductosController < ApplicationController
  before_filter :set_producto, :only => [:show]
  before_filter :set_related, :only => [:show]
  before_filter :set_visto, :only => [:show]

  def index
    @productos = Producto.includes(:marca).padres.order("updated_at DESC").page(params[:page]).per(50)
    authorize! :manage, @productos
  end



  def busqueda2
    query = params[:buscar][:q];
    productos = Producto.search Riddle.escape(query);
    raise productos.inspect
  end


  def busqueda

    params[:buscar][:q] = params[:buscar][:q].gsub(/\//, " ")
    @marcas_seleccionadas = params[:marca].split(",").map{|m| m.to_i } unless params[:marca].nil?
    
    base = Producto.search(params[:buscar][:q], :with => {:publicado => true, :parent_id => 0}, :star => true)
    
    if @marcas_seleccionadas.nil? || @marcas_seleccionadas.empty? 
      @productos_filtrados = base
    else
      @productos_filtrados = Producto.search(params[:buscar][:q], :with => {:publicado => true, :parent_id => 0, :marca_id => @marcas_seleccionadas})
    end

    if params[:ordenar] == "marca"
      @productos_filtrados = Producto.search(params[:buscar][:q], :with => {:publicado => true, :parent_id => 0}, :order => 'marca ASC', :star => true)
    end

    if params[:precio]
      arrange = params[:precio]
      if arrange == 'alto'
        @productos_filtrados = Producto.search(params[:buscar][:q], :with => {:publicado => true, :parent_id => 0}, :order => 'precio DESC', :star => true)
      elsif arrange == 'bajo'
        @productos_filtrados = Producto.search(params[:buscar][:q], :with => {:publicado => true, :parent_id => 0}, :order => 'precio ASC', :star => true)
      end
    end

    @productos = @productos_filtrados.page(params[:page]).per(perparams(params[:ver]))
    @count = @productos_filtrados.count
    a = []
    base.each do |r|
      a << r.marca
    end
    @marcas_para_categoria = a.compact.uniq.sort
  end

  def busqueda_old
    @filtrame = Producto.includes(:marca).padres.publicados.order(("marcas.marca ASC"  if params[:ordenar] == "marca")).order(preciorder(params[:precio])).busqueda(params[:q] || params[:buscar][:q])
    @marcas_seleccionadas = params[:marca].split(",").map{|m| m.to_i } unless params[:marca].nil?
    if params[:marca].blank?
      @productos = Producto.includes(:marca).padres.publicados.order(("marcas.marca ASC"  if params[:ordenar] == "marca")).order(preciorder(params[:precio])).busqueda(params[:q] || params[:buscar][:q]).page(params[:page]).per(perparams(params[:ver]))
    else
      @marca = Marca.find(@marcas_seleccionadas)
      @productos = Producto.includes(:marca).padres.publicados.where(:marca_id => @marca.map{|m| m.id }).order(("marcas.marca ASC"  if params[:ordenar] == "marca")).order(preciorder(params[:precio])).busqueda(params[:q] || params[:buscar][:q]).page(params[:page]).per(perparams(params[:ver]))
    end
    a = []
    @filtrame.each do |r|
      a << r.marca
    end
    @marcas_para_categoria = a.compact.uniq.sort
    @productostotal = Producto.includes(:marca).padres.publicados.busqueda(params[:q] || params[:buscar][:q])
    @productoscount = Producto.includes(:marca).padres.publicados.busqueda(params[:q] || params[:buscar][:q]).count
    respond_to do |format|
      format.js if request.xhr?
      format.html
    end
  end

  def new
    @producto = Producto.new
    authorize! :manage, @producto
  end

  def create
    @producto = Producto.new params[:producto]
    authorize! :manage, @producto
    if @producto.save
      redirect_to producto_ver_path(@producto.slug)
    else
      render :new
    end
  end

  def edit
    @producto = Producto.find params[:id]
    authorize! :manage, @producto
  end

  def update
    @producto = Producto.find params[:id]
    if @producto.update_attributes params[:producto]
      redirect_to producto_ver_path(@producto.slug)
    else
      render :edit
    end
    authorize! :manage, @producto
  end

  def show
    @productos_relacionados = get_related
  end

  def index_admin
    @productos = Producto.all
    authorize! :manage, @productos
    render :index
  end
  
  def destroy
    Producto.delete params[:id]
    authorize! :manage, :destroy
    redirect_to :root
  end

  private

  def set_producto
    @producto = Producto.includes(:marca, :presentaciones).publicados.where(:slug => params[:slug]).first
  end

  def set_related
    @categoria = Categoria.find(@producto.categoria_id) rescue []

  end

  def get_related
    case @categoria.id
    when 67, 68
      @productos_relacionados = Producto.find([9999, 10000, 10001])
    else
      @productos_relacionados = @categoria.productos.padres.publicados.where("productos.id != ?", @producto.id).sample(3)
    end

    if ["651043071801", "651043071818", "809280122958", "809280123252", "879634007460", "682223081020", "811999020500", "607710038486", "3378872084198", "651986905331", "3548752072618", "3348901215985", "607710038479", "3378872084327", "604214923027", "607845083054", "98132315055", "94800348110", "094800348103", "094800348097", "094800348080", "604214922761", "811999020388", "3378872084426", "840090063017", "651043071627", "670367001103", "809280123030", "682223080931", "8410225531425", "8411061788592", "8411061788813", "8426017043205", "3349668526284", "812738013951", "812738013999", "3378872084167", "3378872084358", "3378872084372", "602004062031", "602004063472", "602004063496", "602004064585", "602004064660", "602004064684", "602004065810", "651043071627", "651043071757", "651043071764", "651043071771", "607845038559", "607845016977", "607845040538", "607710039803", "607710039780", "607710038479", "607710038516", "607710038523", "651986905362", "651986905355", "651986905379", "682223080931", "33788720844331", "94800348493", "94800348455"].include?(@producto.upc)
      @productos_relacionados  = Producto.where(:upc => ["651043071801", "651043071818", "809280122958", "809280123252", "879634007460", "682223081020", "811999020500", "607710038486", "3378872084198", "651986905331", "3548752072618", "3348901215985", "607710038479", "3378872084327", "604214923027", "607845083054", "98132315055", "94800348110", "094800348103", "094800348097", "094800348080", "604214922761", "811999020388", "3378872084426", "840090063017", "651043071627", "670367001103", "809280123030", "682223080931", "8410225531425", "8411061788592", "8411061788813", "8426017043205", "3349668526284", "812738013951", "812738013999", "3378872084167", "3378872084358", "3378872084372", "602004062031", "602004063472", "602004063496", "602004064585", "602004064660", "602004064684", "602004065810", "651043071627", "651043071757", "651043071764", "651043071771", "607845038559", "607845016977", "607845040538", "607710039803", "607710039780", "607710038479", "607710038516", "607710038523", "651986905362", "651986905355", "651986905379", "682223080931", "33788720844331", "94800348493", "94800348455"]).sample(3)
    end

    @productos_relacionados
  end

  def set_visto
    visto = @producto.visto;
    if(visto == nil) 
      visto = 1; 
    else 
      visto = visto + 1; 
    end
    Producto.update(@producto.id, {:visto=>visto})
  end
end
