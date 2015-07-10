# = require jquery
# = require jquery_ujs
# = require jquery.ui.all
# = require jquerycookie
# = require redactor
# = require jcarousel

$("#base").hover ->
  $(".base_txt").fadeToggle()
  return
$("#trata").hover ->
  $(".trata_txt").fadeToggle()
  return
$("#bronzer").hover ->
  $(".bronzer_txt").fadeToggle()
  return
$("#ojos_diario").hover ->
  $(".ojos_diario_txt").fadeToggle()
  return
$("#smoky").hover ->
  $(".smoky_txt").fadeToggle()
  return
$("#delineado").hover ->
  $(".delineado_txt").fadeToggle()
  return
$("#pestanas").hover ->
  $(".pestanas_txt").fadeToggle()
  return
$("#labios").hover ->
  $(".labios_txt").fadeToggle()
  return
$("#cejas").hover ->
  $(".cejas_txt").fadeToggle()
  return


$('.eventomodal a').on 'click', (e) ->
  e.preventDefault()
  nombre = $(this).data('nombre')
  descripcion = $(this).data('descripcion')
  fecha = $(this).data('fecha')
  $("#modal .titulo").text(nombre)
  $("#modal .descevento").text(descripcion)
  $("#modal").fadeIn('fast')


$("#producto_descripcion, #producto_ingredientes, #producto_usos, #producto_seccion_descripcion, #post_content, #post_extracto").redactor();

active = false
$(window).scroll ->
  if $("body").scrollTop() > 130
    $("#menu ul.allmenu").appendTo('#head-sup .contenedor').hide().fadeIn('fast')
  else
    $("#head-sup ul.allmenu").appendTo "#menu"

$("#opensearch").on "click", (e) ->
  e.preventDefault()
  $(this).hide()
  $("#realsubmit").show()
  $("#searchbox").show().animate
    width: "160px",
    left: "-160px"
  , 150
  $("#closesubmit").show().animate
    left: "-175px"
  , 150

$("#closesubmit").on "click", (e) ->
  e.preventDefault()
  $("#opensearch").show()
  $("#realsubmit").hide()
  $("#searchbox").animate
    width: "0",
    left: "0"
  , 150, ->
    $(this).hide().val('')
  $("#closesubmit").animate
    left: "0"
  , 150, ->
    $(this).hide()

$("#vermascat").on "click", (e) ->
  e.preventDefault()
  $(".mascat").show()
  $(this).parent("li").hide()

jQuery(document).ready ->
  jQuery("#lonuevo, #bestsellers, #hotnow, #divak1, #divak2").jcarousel
    visible: 5
    buttonNextHTML: '<p id="slideright"></p>'
    buttonPrevHTML: '<p id="slideleft"></p>'
    scroll: 5

$(document).on "click", "a#share", (e) ->
  loc = undefined
  title = undefined
  e.preventDefault()
  loc = $(this).attr("href")
  title = escape($(this).attr("title"))
  window.open "http://www.facebook.com/sharer.php?u=" + loc + "&t=" + title, "facebookwindow", "height=450, width=550, top=" + ($(window).height() / 2 - 225) + ", left=" + $(window).width() / 2 + ", toolbar=0, location=0, menubar=0, directories=0, scrollbars=0"
1

#Popup
path = window.location.pathname
if path == '/'
  unless $.cookie("modal-registro")
    $("#mod").fadeIn()
    $.cookie "modal-registro", "true",
      expires: 365

  $("#makkenform").submit (ev) ->
    ev.preventDefault()
    ev.stopPropagation()
    nombre = $("#makkenform input.nombre").val();
    correo = $("#makkenform input.correo").val();
    $.post "http://pdc.makken.com.mx/sephora/registro_makken.php", {nombre: nombre, email: correo}, (response) ->
      if response.error
      else
        $("#mod").fadeOut 400, ->
          $("#mod").fadeIn 400
          $("#mod").removeClass("register").addClass("thanks")

  $("#makkenregistro").submit (ev) ->
    ev.preventDefault()
    ev.stopPropagation()
    nombre = $("#makkenregistro input.nombre").val();
    correo = $("#makkenregistro input.correo").val();
    $.post "http://pdc.makken.com.mx/sephora/registro_makken.php", {nombre: nombre, email: correo}, (response) ->
      if response.error
      else
        $("#registro_popup").fadeOut 400, ->
          $("#registro_popup form").hide()
          $("#registro_popup .txt_registro_popup").hide()
          $("#registro_popup .texto-gracias").show()
          $("#registro_popup").fadeIn 400
          $("#registro_popup").removeClass("register").addClass("thanks")

$("a.close").live "click", (e) ->
  e.preventDefault()
  $("#mod, #modsuc").fadeOut()

#Registro
$("#btn_mail_enviar").live "click", (e) ->
  e.preventDefault()
  $("#registro_popup").fadeIn()

$("a.close").live "click", (e) ->
  e.preventDefault()
  $("#registro_popup").fadeOut()

#Wallpapers
$("a.back").live "click", (e) ->
  e.preventDefault()
  $("#download").slideUp()
  $("#galeria").slideDown()
original = ''
$("#galeria li").live "click", (e) ->
  original = ''
  e.preventDefault()
  $(".ipad").hide()
  unless $(this).find('img').data('imagen') == null
    $(".ipad").show()
  $('#download .append').empty()
  $('#download .append').append($(this).clone())
  $("#galeria").slideUp()
  $("#download").slideDown()
  original = $(".append img").attr('src')
  $("#download .escritorio").attr('href',original).addClass('imgloading').load ->
      $(this).removeClass 'imgloading'
  input = original.replace(/^.*[\\\/]/, '')
  $("#imagen").attr('value', input)

$("#download .ipad").live "click", (e) ->
  e.preventDefault()
  imagen = $(".append img").data 'imagen'
  $(".append img").attr('src', imagen)
  $("#download .escritorio").attr('href',imagen).addClass('imgloading').load ->
      $(this).removeClass 'imgloading'
  input = imagen.replace(/^.*[\\\/]/, '')
  $("#imagen").attr('value', input)

$("#download .iphone").live "click", (e) ->
  e.preventDefault()
  imagen = $(".append img").data 'imagen'
  $(".append img").attr('src', original)
  $("#download .escritorio").attr('href',original).addClass('imgloading').load ->
      $(this).removeClass 'imgloading'
  input = original.replace(/^.*[\\\/]/, '')
  $("#imagen").attr('value', input)

# ANIVERSARIO
$("#eventolink, #premioslink").live "click", (e) ->
  e.preventDefault()
  if $(this).attr('id') == 'premioslink'
    $(".cerrar").hide()
    $(".cerrar2").show()
  else
    $(".social, .cerrar").show()
    $(".cerrar2").hide()
  href = $(this).attr('href')
  $("#modalcontent .pro img").attr('src', href)
  $("#modal").fadeIn('fast')
$(".cerrar, .cerrar2").live "click", ->
  $("#modal").fadeOut('fast')


$(".regalos-content ul li img").each ->
  esto = $(this)
  fuente = esto.attr("src")
  fuentehover = esto.closest('a').data 'bghover'
  esto.hover (->
    $(this).attr "src", fuentehover
  ), ->
    $(this).attr "src", fuente

$(".tabdesc").hide()
$(".tabdesc:first").show()
$("#tabmenu ul li:first").addClass 'active'
$("#tabmenu li a").last().addClass 'last'
$("#tabmenu ul li a").click (e) ->
  e.preventDefault()
  activeTab = $(this).attr("href")
  $("#tabmenu ul li").removeClass "active"
  $(this).closest('li').addClass "active"
  $(".tabdesc").hide() 
  $(activeTab).show()

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

    $widget_vinculos.after $new_form.css('display', 'block')
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

$('#producto ul.home li').hide()
$('#producto ul.home li:first').show()
(hotnowslider = ->
  $('#producto ul.home li:first').delay(5000).fadeOut()
  $('#producto ul.home li:nth-child(2)').delay(5000).fadeIn().delay(5000).fadeOut()
  $('#producto ul.home li:nth-child(3)').delay(10000).fadeIn().delay(5000).fadeOut '', ->
  $('#producto ul.home li:nth-child(4)').delay(15000).fadeIn().delay(5000).fadeOut '', ->
  $('#producto ul.home li:nth-child(5)').delay(20000).fadeIn().delay(5000).fadeOut '', ->
  $('#producto ul.home li:nth-child(6)').delay(25000).fadeIn().delay(5000).fadeOut '', ->
    $('#producto ul.home li:first').fadeIn()
    hotnowslider()
)()
last = $("#prodclick img").data("normal")
$("#prodclick img").first().addClass("outline")
$("#prodclick img").live "click", ->
  $to_replace = $("#prod, .pro img")
  $("#prodclick img").removeClass("outline")
  unless last == $(this).data("normal")
    $to_replace.attr("src", $(this).data("normal")).addClass('imgloading').load ->
      $(this).removeClass 'imgloading'
  last = $(this).data("normal")
  $("#prodlink").attr("href", $(this).data("full"))
  $("span.precio").text($(this).data("precio"))
  $(".producto").text($(this).data("nombre"))
  $(this).addClass("outline")

$("#proclick img").live "click", ->
  $("#proclick img").removeClass("outline")
  unless last == $(this).data("normal")
    $(".pro img").attr("src", $(this).data("full")).addClass('imgloading').load ->
      $(this).removeClass 'imgloading'
  last = $(this).data("normal")
  $("span.precio").text($(this).data("precio"))
  $(".producto").text($(this).data("nombre"))
  $(this).addClass("outline")

$("#prod, #prodlink").live "click", (e) ->
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
  window.top.location.href = @options[@selectedIndex].value  unless @options[@selectedIndex].value is ""

$("#acomodar").on "change", ->
  window.top.location.href = @options[@selectedIndex].value  unless @options[@selectedIndex].value is ""

ver = getUrlVars()["ver"] || ''
precio = getUrlVars()["precio"] || ''
$(".verpor option[value='ver=" + ver + "']").attr("selected", "selected")
$("#acomodar option[value='precio=" + precio + "']").attr "selected", "selected"

$('#trigger').live "click", ->
  $(this).closest('.navegaciones').find("ul.verpor").toggleClass("activo")
$(".navegaciones ul.verpor").on "mouseleave", ->
  $(this).closest('.navegaciones').find("ul.verpor").toggleClass "activo"

$("#trigger2").live "click", ->
  $(this).closest('.navegaciones').find("ul.aco").toggleClass("activo")
$(".navegaciones ul.aco").on "mouseleave", ->
  $(this).closest('.navegaciones').find("ul.aco").toggleClass "activo"

if $(".navegaciones ul.verpor li a[data-set]") && ver
  $(".filterby").html($(".navegaciones ul.verpor li a[data-set="+ver+"]").data("set") + " por página <sp<an>▼</span>") unless $(".navegaciones ul.verpor li a[data-set="+ver+"]").data("set").nil?
  $(".filterby2").html("precio " +$(".navegaciones ul.aco li a[data-set="+precio+"]").data("set") + "<span>▼</span>") unless $(".navegaciones ul.aco li a[data-set="+precio+"]").data("set").nil?

girl = $("#girl")
$("#izq").hover ->
  girl.removeClass('der')
  girl.addClass('izq')
$("#der").hover ->
  girl.removeClass('izq')
  girl.addClass('der')
if (girl.length > 0)
  $("#wrap").css('position', 'static')
