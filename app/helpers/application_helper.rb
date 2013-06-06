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
end
