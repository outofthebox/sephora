//= require jquery.cookie.js

//= require jquery_ujs
//= require jquery
//= require jquery.ui.all


//= require animacion


var $widget_vinculos, active, getUrlVars, girl, hotnowslider, last, original, path, precio, ver;

$("#base").hover(function() {
  $(".base_txt").fadeToggle();
});

$("#trata").hover(function() {
  $(".trata_txt").fadeToggle();
});

$("#bronzer").hover(function() {
  $(".bronzer_txt").fadeToggle();
});

$("#ojos_diario").hover(function() {
  $(".ojos_diario_txt").fadeToggle();
});

$("#smoky").hover(function() {
  $(".smoky_txt").fadeToggle();
});

$("#delineado").hover(function() {
  $(".delineado_txt").fadeToggle();
});

$("#pestanas").hover(function() {
  $(".pestanas_txt").fadeToggle();
});

$("#labios").hover(function() {
  $(".labios_txt").fadeToggle();
});

$("#cejas").hover(function() {
  $(".cejas_txt").fadeToggle();
});

$('.eventomodal a').on('click', function(e) {
  var descripcion, fecha, nombre;
  e.preventDefault();
  nombre = $(this).data('nombre');
  descripcion = $(this).data('descripcion');
  fecha = $(this).data('fecha');
  $("#modal .titulo").text(nombre);
  $("#modal .descevento").text(descripcion);
  return $("#modal").fadeIn('fast');
});

active = false;

$(window).scroll(function() {
  if ($("body").scrollTop() > 130) {
    return $("#menu ul.allmenu").appendTo('#head-sup .contenedor').hide().fadeIn('fast');
  } else {
    return $("#head-sup ul.allmenu").appendTo("#menu");
  }
});

$("#opensearch").on("click", function(e) {
  e.preventDefault();
  $(this).hide();
  $("#realsubmit").show();
  $("#searchbox").show().animate({
    width: "160px",
    left: "-160px"
  }, 150);
  return $("#closesubmit").show().animate({
    left: "-175px"
  }, 150);
});

$("#closesubmit").on("click", function(e) {
  e.preventDefault();
  $("#opensearch").show();
  $("#realsubmit").hide();
  $("#searchbox").animate({
    width: "0",
    left: "0"
  }, 150, function() {
    return $(this).hide().val('');
  });
  return $("#closesubmit").animate({
    left: "0"
  }, 150, function() {
    return $(this).hide();
  });
});

$("#vermascat").on("click", function(e) {
  e.preventDefault();
  $(".mascat").show();
  return $(this).parent("li").hide();
});

jQuery(document).ready(function() {
  return jQuery("#lonuevo, #bestsellers, #hotnow, #divak1, #divak2").jcarousel({
    visible: 5,
    buttonNextHTML: '<p id="slideright"></p>',
    buttonPrevHTML: '<p id="slideleft"></p>',
    scroll: 5
  });
});

$(document).on("click", "a#share", function(e) {
  var loc, title;
  loc = void 0;
  title = void 0;
  e.preventDefault();
  loc = $(this).attr("href");
  title = escape($(this).attr("title"));
  return window.open("http://www.facebook.com/sharer.php?u=" + loc + "&t=" + title, "facebookwindow", "height=450, width=550, top=" + ($(window).height() / 2 - 225) + ", left=" + $(window).width() / 2 + ", toolbar=0, location=0, menubar=0, directories=0, scrollbars=0");
});

1;

path = window.location.pathname;

if (path === '/') {
  $("#makkenform").submit(function(ev) {
    var correo, nombre;
    ev.preventDefault();
    ev.stopPropagation();
    nombre = $("#makkenform input.nombre").val();
    correo = $("#makkenform input.correo").val();
    return $.post("http://pdc.makken.com.mx/sephora/registro_makken.php", {
      nombre: nombre,
      email: correo
    }, function(response) {
      if (response.error) {

      } else {
        return $("#mod").fadeOut(400, function() {
          $("#mod").fadeIn(400);
          return $("#mod").removeClass("register").addClass("thanks");
        });
      }
    });
  });
}

$("a.close").live("click", function(e) {
  e.preventDefault();
  return $("#mod, #modsuc").fadeOut();
});

$("a.back").live("click", function(e) {
  e.preventDefault();
  $("#download").slideUp();
  return $("#galeria").slideDown();
});

original = '';

$("#galeria li").live("click", function(e) {
  var input;
  original = '';
  e.preventDefault();
  $(".ipad").hide();
  if ($(this).find('img').data('imagen') !== null) {
    $(".ipad").show();
  }
  $('#download .append').empty();
  $('#download .append').append($(this).clone());
  $("#galeria").slideUp();
  $("#download").slideDown();
  original = $(".append img").attr('src');
  $("#download .escritorio").attr('href', original).addClass('imgloading').load(function() {
    return $(this).removeClass('imgloading');
  });
  input = original.replace(/^.*[\\\/]/, '');
  return $("#imagen").attr('value', input);
});

$("#download .ipad").live("click", function(e) {
  var imagen, input;
  e.preventDefault();
  imagen = $(".append img").data('imagen');
  $(".append img").attr('src', imagen);
  $("#download .escritorio").attr('href', imagen).addClass('imgloading').load(function() {
    return $(this).removeClass('imgloading');
  });
  input = imagen.replace(/^.*[\\\/]/, '');
  return $("#imagen").attr('value', input);
});

$("#download .iphone").live("click", function(e) {
  var imagen, input;
  e.preventDefault();
  imagen = $(".append img").data('imagen');
  $(".append img").attr('src', original);
  $("#download .escritorio").attr('href', original).addClass('imgloading').load(function() {
    return $(this).removeClass('imgloading');
  });
  input = original.replace(/^.*[\\\/]/, '');
  return $("#imagen").attr('value', input);
});

$("#eventolink, #premioslink").live("click", function(e) {
  var href;
  e.preventDefault();
  if ($(this).attr('id') === 'premioslink') {
    $(".cerrar").hide();
    $(".cerrar2").show();
  } else {
    $(".social, .cerrar").show();
    $(".cerrar2").hide();
  }
  href = $(this).attr('href');
  $("#modalcontent .pro img").attr('src', href);
  return $("#modal").fadeIn('fast');
});

$(".cerrar, .cerrar2").live("click", function() {
  return $("#modal").fadeOut('fast');
});

$(".regalos-content ul li img").each(function() {
  var esto, fuente, fuentehover;
  esto = $(this);
  fuente = esto.attr("src");
  fuentehover = esto.closest('a').data('bghover');
  return esto.hover((function() {
    return $(this).attr("src", fuentehover);
  }), function() {
    return $(this).attr("src", fuente);
  });
});

$(".tabdesc").hide();

$(".tabdesc:first").show();

$("#tabmenu ul li:first").addClass('active');

$("#tabmenu li a").last().addClass('last');

$("#tabmenu ul li a").click(function(e) {
  var activeTab;
  e.preventDefault();
  activeTab = $(this).attr("href");
  $("#tabmenu ul li").removeClass("active");
  $(this).closest('li').addClass("active");
  $(".tabdesc").hide();
  return $(activeTab).show();
});

$("select#marcas").on('change', function(e) {
  return window.location = $(this).val();
});

$('.select').hover(function() {
  return $('.trigger span').toggleClass('active');
});

if (($widget_vinculos = $(".widget-seccion-producto-vincular")).size()) {
  $widget_vinculos.on("submit", function(e) {
    var $search, $this;
    e.preventDefault();
    $this = $(this);
    $search = $(this).find("#busqueda_q");
    return $.ajax({
      type: 'GET',
      url: $this.attr('action'),
      data: "q=" + ($search.val()),
      complete: function(response) {
        return $this.find(".resultados").html(response.responseText);
      }
    });
  });
  $(".producto-vincular").live('click', function(e) {
    var $new_form, $this;
    $this = $(this);
    $new_form = $(".widget-seccion-producto-form:not(:visible)").clone();
    $(".widget-seccion-producto-form:visible").remove();
    $widget_vinculos.after($new_form.css('display', 'block'));
    $new_form.find("textarea").get(0).focus();
    $new_form.find("#producto_seccion_producto_id, #categoria_producto_producto_id, #marca_producto_producto_id").val($this.data("producto-id"));
    return $new_form.find(".tmpl-producto-nombre").text($this.data("producto-nombre"));
  });
  $(".vinculo-producto").closest("ul").sortable({
    update: function(e) {
      var $csrf_param, $csrf_token, $form, orden;
      orden = [];
      $form = $("<form>").hide().appendTo("body");
      $csrf_param = $("meta[name='csrf-param']");
      $csrf_token = $("meta[name='csrf-token']");
      $.each([$csrf_param, $csrf_token], function(k, v) {
        return $("<input>", {
          name: v.attr("name"),
          value: v.attr("content")
        }).appendTo($form);
      });
      $(this).find("> li").each(function() {
        return $("<input>", {
          name: 'vinculo_id[]',
          value: $(this).data("vinculo-id")
        }).appendTo($form);
      });
      return $.ajax({
        type: 'POST',
        url: $("ul.productos-vinculados").data('cambiar-orden-url'),
        data: $form.serialize(),
        complete: function(response) {
          return $form.remove();
        }
      });
    }
  });
}

$('#producto ul.home li').hide();

$('#producto ul.home li:first').show();

(hotnowslider = function() {
  $('#producto ul.home li:first').delay(5000).fadeOut();
  $('#producto ul.home li:nth-child(2)').delay(5000).fadeIn().delay(5000).fadeOut();
  $('#producto ul.home li:nth-child(3)').delay(10000).fadeIn().delay(5000).fadeOut('', function() {});
  $('#producto ul.home li:nth-child(4)').delay(15000).fadeIn().delay(5000).fadeOut('', function() {});
  $('#producto ul.home li:nth-child(5)').delay(20000).fadeIn().delay(5000).fadeOut('', function() {});
  return $('#producto ul.home li:nth-child(6)').delay(25000).fadeIn().delay(5000).fadeOut('', function() {
    $('#producto ul.home li:first').fadeIn();
    return hotnowslider();
  });
})();

last = $("#prodclick img").data("normal");

$("#prodclick img").first().addClass("outline");

$("#prodclick img").live("click", function() {
  var $to_replace;
  $to_replace = $("#prod, .pro img");
  $("#prodclick img").removeClass("outline");
  if (last !== $(this).data("normal")) {
    $to_replace.attr("src", $(this).data("normal")).addClass('imgloading').load(function() {
      return $(this).removeClass('imgloading');
    });
  }
  last = $(this).data("normal");
  $("#prodlink").attr("href", $(this).data("full"));
  $("span.precio").text($(this).data("precio"));
  $(".producto").text($(this).data("nombre"));
  return $(this).addClass("outline");
});

$("#proclick img").live("click", function() {
  $("#proclick img").removeClass("outline");
  if (last !== $(this).data("normal")) {
    $(".pro img").attr("src", $(this).data("full")).addClass('imgloading').load(function() {
      return $(this).removeClass('imgloading');
    });
  }
  last = $(this).data("normal");
  $("span.precio").text($(this).data("precio"));
  $(".producto").text($(this).data("nombre"));
  return $(this).addClass("outline");
});

$("#prod, #prodlink").live("click", function(e) {
  var href;
  e.preventDefault();
  href = $("#prodlink").attr('href');
  $("#modalcontent .pro img").attr('src', href);
  $("#modalbox").fadeIn();
  $("#proclick img").removeClass("outline");
  return $("#proclick img[data-full='" + href + "']").addClass("outline");
});

$(".cerrar").live("click", function() {
  return $("#modalbox").fadeOut();
});

$(".behindbutton").live("click", function(e) {
  return $(".behindthebrand").slideToggle();
});

getUrlVars = function() {
  var parts, vars;
  vars = {};
  parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/g, function(m, key, value) {
    return vars[key] = value;
  });
  return vars;
};

$("#verpor").on("change", function() {
  if (this.options[this.selectedIndex].value !== "") {
    return window.top.location.href = this.options[this.selectedIndex].value;
  }
});

$("#acomodar").on("change", function() {
  if (this.options[this.selectedIndex].value !== "") {
    return window.top.location.href = this.options[this.selectedIndex].value;
  }
});

ver = getUrlVars()["ver"] || '';

precio = getUrlVars()["precio"] || '';

$(".verpor option[value='ver=" + ver + "']").attr("selected", "selected");

$("#acomodar option[value='precio=" + precio + "']").attr("selected", "selected");

$('#trigger').live("click", function() {
  return $(this).closest('.navegaciones').find("ul.verpor").toggleClass("activo");
});

$(".navegaciones ul.verpor").on("mouseleave", function() {
  return $(this).closest('.navegaciones').find("ul.verpor").toggleClass("activo");
});

$("#trigger2").live("click", function() {
  return $(this).closest('.navegaciones').find("ul.aco").toggleClass("activo");
});

$(".navegaciones ul.aco").on("mouseleave", function() {
  return $(this).closest('.navegaciones').find("ul.aco").toggleClass("activo");
});

if ($(".navegaciones ul.verpor li a[data-set]") && ver) {
  if ($(".navegaciones ul.verpor li a[data-set=" + ver + "]").data("set").nil == null) {
    $(".filterby").html($(".navegaciones ul.verpor li a[data-set=" + ver + "]").data("set") + " por página <sp<an>▼</span>");
  }
  if ($(".navegaciones ul.aco li a[data-set=" + precio + "]").data("set").nil == null) {
    $(".filterby2").html("precio " + $(".navegaciones ul.aco li a[data-set=" + precio + "]").data("set") + "<span>▼</span>");
  }
}

girl = $("#girl");

$("#izq").hover(function() {
  girl.removeClass('der');
  return girl.addClass('izq');
});

$("#der").hover(function() {
  girl.removeClass('izq');
  return girl.addClass('der');
});

// ---
// generated by coffee-script 1.9.2