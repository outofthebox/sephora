# = require jquery
# = require jquery_ujs
# = require jquery.ui.all

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
  
  $(".producto-vincular").live 'click', (e) ->
    $this = $(this)
    $new_form = $(".widget-seccion-producto-form:not(:visible)").clone()
    $(".widget-seccion-producto-form:visible").remove()

    $secciones_busqueda.after $new_form.show()
    $new_form.find("textarea").get(0).focus()
    $new_form.find("#producto_seccion_producto_id").val $this.data("producto-id")
    $new_form.find(".tmpl-producto-nombre").text $this.data("producto-nombre")

  $(".vinculo-producto").closest("ul").sortable
    update: (e) ->
      orden = []
      $form = $("<form>").hide().appendTo "body"

      $csrf_param = $("meta[name='csrf-param']")
      $csrf_token = $("meta[name='csrf-token']")

      $.each [$csrf_param, $csrf_token], (k, v) ->
        $("<input>",
          name: v.attr "name"
          value: v.attr "content"
        ).appendTo $form

      $(this).find("> li").each ->
        $("<input>",
          name: 'vinculo_id[]'
          value: $(this).data("vinculo-id")
        ).appendTo $form

      $.ajax
        type: 'POST'
        url: '/secciones/actualizar_orden'
        data: $form.serialize()
        complete: (response) ->
          $form.remove()



