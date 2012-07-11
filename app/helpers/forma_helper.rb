module FormaHelper
  def form_error model, field
    if model.errors[field].any?
      error = model.errors[field].first
      "<div><span class='error'><strong>Error: </strong><span class='mensaje'>#{error}</span></span></div>".html_safe
    end
  end
end
