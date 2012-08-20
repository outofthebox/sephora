# = require jquery
# = require jquery_ujs

if ($secciones_busqueda = $(".widget-seccion-producto-vincular")).size()
  $secciones_busqueda.on "submit", (e) ->
    e.preventDefault()
    $this = $(this)
    $search = $(this).find "#busqueda_q"
    $.ajax
      type: 'GET'
      url: $this.attr 'action'
      data: "q=#{$search.val()}"
      complete: (response)->
        $this.find(".resultados").html response.responseText
  
  $vincular_forma = $
  $(".producto-vincular").live 'click', (e) ->
    $this = $(this)
    $new_form = $(".widget-seccion-producto-form:not(:visible)").clone()
    $(".widget-seccion-producto-form:visible").remove()

    $secciones_busqueda.after $new_form.show()
    $new_form.find("textarea").get(0).focus()
    $new_form.find("#producto_seccion_producto_id").val $this.data("producto-id")
    $new_form.find(".tmpl-producto-nombre").text $this.data("producto-nombre")

