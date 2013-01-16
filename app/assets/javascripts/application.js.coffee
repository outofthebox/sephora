# = require jquery
# = require jquery_ujs
# = require jquery.ui.all
# = require jquerycookie
$("#menu ul li").live
  mouseenter: ->
    $(this).find('.submenu').show();
  mouseleave: ->
    $(this).find('.submenu').hide();

count = 1
$(".prox.jesus").live "click", ->
  $(this).removeClass('jesus')
  if $(".slider").css('margin-left') == '-2280px'
    $(".slider").stop().animate {"margin-left": "+=300%"}, "slow", ->
      $(".prox").addClass('jesus')
    count = 1
    $(".prox p").text(count + '/4')
  else
    $(".slider").stop().animate {"margin-left": "-=100%"}, "slow", ->
      $(".prox").addClass('jesus')
    count = count + 1
    $(".prox p").text(count + '/4')
$(".ante.jesus").live "click", ->
  $(this).removeClass('jesus')
  if $(".slider").css('margin-left') == '0px'
    $(".slider").stop().animate {"margin-left": "-=300%"}, "slow", ->
      $(".ante").addClass('jesus')
    count = 4
    $(".prox p").text(count + '/4')
  else
    $(".slider").stop().animate {"margin-left": "+=100%"}, "slow", ->
      $(".ante").addClass('jesus')
    count = count - 1
    $(".prox p").text(count + '/4')

#Popup
path = window.location.pathname
if path == '/'
  if $.cookie("popholi")
  else
    $("#popholi").fadeIn()
    $.cookie "popholi", "true",
    expires: 1
$("#popholi a.close").live "click", (e) ->
  e.preventDefault()
  $("#popholi").fadeOut()
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
    $(".social, .cerrar").hide()
    $(".cerrar2").show()
  else
    $(".social, .cerrar").show()
    $(".cerrar2").hide()
  href = $(this).attr('href')
  $("#modalcontent .pro img").attr('src', href)
  $("#modal").fadeIn()
$(".cerrar, .cerrar2").live "click", ->
  $("#modal").fadeOut()


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

slidersize1 = (165+25)*$(".bestsellers li").length
slidersize2 = (165+25)*$(".lonuevo li").length
$(".bestsellers").css('width', slidersize1)
$(".lonuevo").css('width', slidersize2)

$("#slideright").live "dblclick", (e)->
  e.preventDefault()

$("#slideright").live "click", (e)->
  leftgo = parseInt($(".bestsellers").css('left'), 10)
  $(".bestsellers").css('left', leftgo - 945 + 'px' )
  if parseInt($(".bestsellers").css('left'), 10) == (($(".bestsellers li").length/5)*945)*-1
    $(".bestsellers").css('left', '0' )

$("#slideleft").live "click", ->
  leftgo = parseInt($(".bestsellers").css('left'), 10)
  $(".bestsellers").css('left', leftgo + 945 + 'px' )
  if leftgo == 0
    $(".bestsellers").css('left', ((($(".bestsellers li").length/5)*945)*-1)/2 + 'px' )

$("#slideright2").live "click", ->
  leftgo = parseInt($(".lonuevo").css('left'), 10)
  $(".lonuevo").css('left', leftgo - 945 + 'px' )
  if parseInt($(".lonuevo").css('left'), 10) == (($(".lonuevo li").length/5)*945)*-1
    $(".lonuevo").css('left', '0' )

$("#slideleft2").live "click", ->
  leftgo = parseInt($(".lonuevo").css('left'), 10)
  $(".lonuevo").css('left', leftgo + 945 + 'px' )
  if leftgo == 0
    $(".lonuevo").css('left', '0' )

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

$('#producto ul.home li').hide()
$('#producto ul.home li:first').show()
(hotnowslider = ->
  $('#producto ul.home li:first').delay(5000).fadeOut()
  $('#producto ul.home li:nth-child(2)').delay(5000).fadeIn().delay(5000).fadeOut()
  $('#producto ul.home li:nth-child(3)').delay(10000).fadeIn().delay(5000).fadeOut '', ->
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
