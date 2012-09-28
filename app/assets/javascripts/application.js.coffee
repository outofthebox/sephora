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

$('#producto ul li').hide()
$('#producto ul li:first').show()
(hotnowslider = ->
  $('#producto ul li:first').delay(5000).fadeOut()
  $('#producto ul li:nth-child(2)').delay(5000).fadeIn().delay(5000).fadeOut()
  $('#producto ul li:nth-child(3)').delay(10000).fadeIn().delay(5000).fadeOut '', ->
    $('#producto ul li:first').fadeIn()
    hotnowslider()
)()
  
$("#prodclick img").first().addClass("outline")
$("#prodclick img").live "click", ->
  $to_replace = $("#prod, .pro img")
  $("#prodclick img").removeClass("outline")
  $to_replace.attr("src", $(this).data("normal")).addClass('imgloading').load ->
    $(this).removeClass 'imgloading'
  $("#prodlink").attr("href", $(this).data("full"))
  $("span.precio").text($(this).data("precio"))
  $(".producto").text($(this).data("nombre"))
  $(this).addClass("outline")

$("#proclick img").live "click", ->
  $("#proclick img").removeClass("outline")
  $(".pro img").attr("src", $(this).data("full")).addClass('imgloading').load ->
    $(this).removeClass 'imgloading'
  $("span.precio").text($(this).data("precio"))
  $(".producto").text($(this).data("nombre"))
  $(this).addClass("outline")

$("#prod").live "click", (e) ->
  e.preventDefault()
  href = $("#prodlink").attr('href')
  $("#modalcontent .pro img").attr('src', href)
  $("#modalbox").fadeIn()
  $("#proclick img").removeClass("outline")
  $("#proclick img[data-full='"+href+"']").addClass("outline")
$(".cerrar").live "click", ->
  $("#modalbox").fadeOut()

$(".behindbutton").live "click", (e) ->
  $(".behindthebrand").slideToggle()

getUrlVars = ->
  vars = {}
  parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/g, (m, key, value) ->
    vars[key] = value
  )
  vars

$("#verpor").on "change", ->
  # window.top.location.href = @options[@selectedIndex].value  unless @options[@selectedIndex].value is ""

$("#acomodar").on "change", ->
  window.top.location.href = @options[@selectedIndex].value  unless @options[@selectedIndex].value is ""

ver = getUrlVars()["ver"]
precio = getUrlVars()["precio"]
$("#verpor option[value='ver=" + ver + "']").attr "selected", "selected"
$("#acomodar option[value='precio=" + precio + "']").attr "selected", "selected"

$('#trigger').live "click", ->
  $(this).closest('.navegaciones').find("ul.verpor").toggleClass("activo")
$(".navegaciones ul.verpor").on "mouseleave", ->
  $(this).closest('.navegaciones').find("ul.verpor").toggleClass "activo"

$("#trigger2").live "click", ->
  $(this).closest('.navegaciones').find("ul.aco").toggleClass("activo")
$(".navegaciones ul.aco").on "mouseleave", ->
  $(this).closest('.navegaciones').find("ul.aco").toggleClass "activo"

$("#trigger").html($(".navegaciones ul.verpor li a[data-set="+ver+"]").data("set") + " por página <span>▼</span>") unless $(".navegaciones ul.verpor li a[data-set="+ver+"]").data("set").nil?
$("#trigger2").html("precio " +$(".navegaciones ul.aco li a[data-set="+precio+"]").data("set") + "<span>▼</span>") unless $(".navegaciones ul.aco li a[data-set="+precio+"]").data("set").nil?
