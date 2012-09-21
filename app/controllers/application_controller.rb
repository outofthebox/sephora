class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :mini_hash, :check_minihash

  before_filter do
    @marcas_all = Marca.order(:marca)
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
  end if Rails.env.production?

  def perparams per, arr = [20,30,50]
    (arr & [per.to_i]).first
  end
  def marcaparams per, arr = [75, 74, 77, 1, 78, 80, 82, 2, 84, 86, 3, 4, 5, 6, 7, 88, 8, 90, 89, 91, 92, 9, 10, 11, 12, 13, 14, 16, 15, 17, 18, 94, 95, 96, 97, 19, 20, 21, 22, 23, 24, 98, 25, 26, 27, 100, 28, 29, 69, 61, 30, 31, 32, 33, 63, 62, 64, 34, 65, 35, 66, 67, 36, 68, 37, 38, 40, 70, 71, 72, 41, 73, 42, 101, 99, 43, 44, 45, 46, 47, 48, 93, 49, 51, 52, 87, 53, 50, 85, 54, 83, 81, 55, 56, 57, 58, 59, 79, 76, 60]
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
