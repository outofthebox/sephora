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

  def perparams per, arr = [10,20,50]
    (arr & [per.to_i]).first
  end
end
