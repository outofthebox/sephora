module PaginasHelper
  def activo?(page_name)
    "activo" if params[:action] == page_name
  end
end
