module ApplicationHelper
  def submenu(slug)
    e = Categoria.includes(:productos).by_slug(slug).first
    p = e.descendants.reject{|r| r.parent_id != e.id }
    return p
  end
end
