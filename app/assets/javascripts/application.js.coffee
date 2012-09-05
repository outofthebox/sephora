# = require jquery
# = require jquery_ujs
# = require jquery.ui.all

$("select#marcas").on 'change', (e) ->
  window.location = $(this).val()
$('.select').hover ->
  $('.trigger span').toggleClass('active')

if ($widget_vinculos = $(".widget-seccion-producto-vincular")).size()
  $widget_vinculos.on "submit", (e) ->
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

    $widget_vinculos.after $new_form.show()
    $new_form.find("textarea").get(0).focus()
    $new_form.find("#producto_seccion_producto_id, #categoria_producto_producto_id, #marca_producto_producto_id").val $this.data("producto-id")
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
        url: $("ul.productos-vinculados").data 'cambiar-orden-url'
        data: $form.serialize()
        complete: (response) ->
          $form.remove()
$(".prox").live "click", ->
  $(".slider").animate({"margin-left": "-100%"}, "slow")
$(".ante").live "click", ->
  $(".slider").animate({"margin-left": "0"}, "slow")
  
$("#prodclick img").first().addClass("outline")
$("#prodclick img").live "click", ->
  $("#prodclick img").removeClass("outline")
  $("#prod").attr("src", $(this).data("normal"))
  $("#prodlink").attr("href", $(this).data("full"))
  $("span.precio").text("$" + $(this).data("precio") + ".0")
  $(".producto").text($(this).data("nombre"))
  $(this).addClass("outline")

$("#prod").live "click", ->
  event.preventDefault()
  $("#modalcontent").remove()
  href = $("#prodlink").attr('href')
  $("#modalbox").fadeIn()
  $("#modalbox").append("<div id='modalcontent'><img src='"+href+"' /></div>")
$(".cerrar").live "click", ->
  $("#modalbox").fadeOut()
