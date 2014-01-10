# = require jquery
# = require jquery_ujs
# = require jquery.ui.all
# = require jquerycookie
# = require redactor
# = require jcarousel

#((a, b) ->
#  window.location = b  if /(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino/i.test(a) or /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0, 4))
#) navigator.userAgent or navigator.vendor or window.opera, "/mobile"


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
  jQuery("#lonuevo, #bestsellers").jcarousel
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


$("ul.allmenu li").live
  mouseenter: ->
    $(this).find('.submenu').show();
  mouseleave: ->
    $(this).find('.submenu').hide();

rotate = ->
  $(".prox.jesus").click()

intervalID = setInterval(->
  rotate()
, 5000)

count = 1
slides = $(".diapositiva").size()
width = 760
counter = '/' + slides
$(".prox p").text('1' + counter)
$(".prox.jesus").live "click", ->
  clearInterval intervalID
  intervalID = setInterval(->
    rotate()
  , 5000)
  $(this).removeClass('jesus')
  if $(".slider").css('margin-left') == '-'+width*(slides-1)+'px'
    $(".slider").stop().animate {"margin-left": "+="+(slides-1)+"00%"}, "slow", ->
      $(".prox").addClass('jesus')
    count = 1
    $(".prox p").text(count + counter)
  else
    $(".slider").stop().animate {"margin-left": "-=100%"}, "slow", ->
      $(".prox").addClass('jesus')
    count = count + 1
    $(".prox p").text(count + counter)
$(".ante.jesus").live "click", ->
  clearInterval intervalID
  intervalID = setInterval(->
    rotate()
  , 5000)
  $(this).removeClass('jesus')
  if $(".slider").css('margin-left') == '0px'
    $(".slider").stop().animate {"margin-left": "-="+(slides-1)+"00%"}, "slow", ->
      $(".ante").addClass('jesus')
    count = slides
    $(".prox p").text(count + counter)
  else
    $(".slider").stop().animate {"margin-left": "+=100%"}, "slow", ->
      $(".ante").addClass('jesus')
    count = count - 1
    $(".prox p").text(count + counter)

#Popup
path = window.location.pathname
if path == '/'
  unless $.cookie("mod")
    $("#mod").fadeIn()
    $.cookie "mod", "true",
      expires: 365
$("a.close").live "click", (e) ->
  e.preventDefault()
  $("#mod, #modsuc").fadeOut()

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

$(".filterby").html($(".navegaciones ul.verpor li a[data-set="+ver+"]").data("set") + " por página <sp<an>▼</span>") unless $(".navegaciones ul.verpor li a[data-set="+ver+"]").data("set").nil?
$(".filterby2").html("precio " +$(".navegaciones ul.aco li a[data-set="+precio+"]").data("set") + "<span>▼</span>") unless $(".navegaciones ul.aco li a[data-set="+precio+"]").data("set").nil?
