class SephoraCollectionController < ApplicationController
  layout "sephora_collection"
  before_filter :set_bg_white, :only => :maquillaje
  before_filter :set_bg_black, :only => :index
  before_filter :get_productos, :only => [:interna, :load_squares]
  before_filter :get_collection, :only => :interna
  before_filter :set_bg_white, :only => :promociones

  def index
  end

  def internas
  end

  def outrageus_land
  end

  def foundation_land
  end

  def rouge_land
  end

  def load_squares
    render :partial => "squares", :locals => {:post => []}
  end

  private

  def set_bg_white
    @background = "white"
  end

  def set_bg_black
    @background = "black"
  end

  def get_productos
    case params[:interna]
    when "maquillaje"
      productos = Producto.where(:upc => ["3378872072713","3378872079101","3378872059899","3378872073192","3378872068556","3378872078715","1332048","3378872063827","3378872080572"]);
      @productos = productos.sample(6);
    when "skincare"
      productos =  Producto.where(:upc => ["3378872062776","3378872055440","3378872066095","1258383","3378872077558","1258342","1258334","3378872066156","3378872051077"])
      @productos = productos.sample(6);
    when "accesorios"
      productos = Producto.where(:upc => ["3378872043249", "3378872051336", "400013564924", "3378872049555", "400013774804", "3378872027935", "3378872047599", "400010329113", "3378872070115"])
      @productos = productos.sample(6)
    when "bath"
      productos = Producto.where(:upc => ["3378872060857", "3378872079736", "3378872065517", "3378872061410", "3378872061557", "3378872079781", "3378872060710", "3378872061694", "3378872066170"])
      @productos = productos.sample(6)
    end
  end

  def get_collection
    interna = params[:interna]
    if ["maquillaje", "skincare", "accesorios", "bath"].include?(interna)
      @collection = interna
    else
      @collection = "maquillaje"
    end
    gon.collection = @collection
  end
end
