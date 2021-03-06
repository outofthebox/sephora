module ApplicationHelper
  def submenu(slug)
    e = Categoria.includes(:productos).by_slug(slug).first
    p = e.descendants.reject{|r| r.parent_id != e.id }
    return p
  end
  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end
  def image_url(file)
    request.protocol + request.host_with_port + image_path(file)
  end

  def setup_animation_carousel(animation_carousel)
    1.times { animation_carousel.carousels.build } if animation_carousel.carousels.count == 0
    return animation_carousel
  end
end
