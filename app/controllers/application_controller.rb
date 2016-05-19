class ApplicationController < ActionController::Base
  protect_from_forgery

  #before_filter :redirect_main_domain if Rails.env.production?
  before_filter :redirect_mobile
  before_filter :set_search_engine, except: [:suscribe, :create, :new]


  def set_search_engine
    @search_cats = []; 
  end

  def redirect_main_domain
    dominio = 'sephora.com.mx'
    if request.env["rack.url_scheme"] == "https" 
      if request.env['HTTP_HOST'] == "sephoramexico.herokuapp.com"
      else
        if request.env['HTTP_HOST'] != dominio
          redirect_to "https://#{dominio}#{request.fullpath}"
        end
      end
    else
      if request.env['HTTP_HOST'] != dominio
        redirect_to "http://#{dominio}#{request.fullpath}"
      end
    end
  end

  def redirect_mobile
    arr_str = request.original_url.split("/");
    if arr_str.include?("mobile") == false
      if /(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino/i.match(request.user_agent) || /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.match(request.user_agent[0..3])
        if Rails.env.production?
          redirect_to "#{request.protocol + request.host}/mobile/#{request.fullpath}"
        else
          redirect_to "#{request.protocol + request.host_with_port}/mobile/#{request.fullpath}" unless ["/usuarios/sign_in"].include?(request.fullpath)
        end
      end
    end
  end


  def is_mobile?
    /(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino/i.match(request.user_agent) || /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.match(request.user_agent[0..3])
  end

  def select_layout_type
    if is_mobile?
      "mobile"
    else
      "application"
    end
  end

  def clear_cache
    ActionController::Base.new.expire_fragment("categoria_ver", options = nil)

    puts "[--Cache Limpio--]"


    redirect_to root_path
  end

  # -----------------------------
  # I was searching
  # You were on a mission
  # And our hearts combined like
  # A neutron star collision
  # -----------------------------

  # Para devise http://stackoverflow.com/questions/4982073/different-layout-for-sign-in-action-in-devise
  layout :layout_by_resource
  helper_method :mini_hash, :check_minihash

  before_filter do
    @marcas_all = Marca.con_productos
    @bgcategorias = BlogCategoria.order('id ASC').first(4)
  end

  def layout_by_resource
    "application"
  end

  def after_sign_in_path_for(resource)
    if is_mobile?
      m_usuario_perfil_path
    else
      usuario_path
    end
  end

  def current_user
    current_usuario
  end
  
  # minihash
  def mini_hash str
    str = hash_normalize str
    str = "#{str}~#{current_usuario.try(:id) || request.remote_ip}~#{Date.today.to_s}"
    shortnum Digest::MD5.hexdigest(str.to_s)[0..7].to_i(16)
  end

  def check_minihash str, hash
    str = hash_normalize str
    hashes = []
    [:today, :tomorrow].each do |m|
      tmp = "#{str}~#{current_usuario.try(:id) || request.remote_ip}~#{Date.send(m).to_s}"
      hashes << shortnum(Digest::MD5.hexdigest(tmp.to_s)[0..7].to_i(16))
    end
    hashes.include? hash
  end

  def hash_normalize obj
    if obj.kind_of? Array
      arr = []
      obj.each do |o|
        arr << hash_normalize(o)
      end
      arr.join '~'
    elsif !obj.kind_of? String
      "#{obj.class.name}-#{obj.id}"
    else
      obj
    end
  end

  def shortnum n
    codeset = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    base = codeset.size
    converted = ""
    while n > 0 do
      converted = "#{codeset[(n % base)]}#{converted}"
      n = (n/base).floor
    end

    converted[0...3]
  end

  rescue_from Exception do |exception|
    render :file => "error/404", :status => 404
  end if Rails.env.production? && (ENV['DEBUG'] || '').empty?

  def perparams per, arr = [20,30,50]
    (arr & [per.to_i]).first
  end
  
  def preciorder arrange = ''
    if arrange == 'alto'
      'precio DESC'
    elsif arrange == 'bajo'
      'precio ASC'
    end
  end

end
