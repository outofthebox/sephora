# = require jquery

#-
#- FB JSSDK
#-

((d, s, id) ->
    js = undefined
    fjs = d.getElementsByTagName(s)[0]
    return  if d.getElementById(id)
    js = d.createElement(s)
    js.id = id
    js.src = "//connect.facebook.net/es_LA/all.js#xfbml=1&appId=1406140066193642";
    fjs.parentNode.insertBefore js, fjs
  ) document, "script", "facebook-jssdk"

#-
#- Declaracion de variables
#-

wishlist_cont = 0;

#-
#- Declaracion de funciones
#-
initSlide = (cont, move) ->
	$(".slider_items."+cont+" .right").click (ev) ->
		ev.preventDefault();
		$this = $(this);
		this.disabled = "disabled";
		$holiday = $("#"+cont+"_cont");
		if($holiday.position().left >= -1020)
			$holiday.css("left", $holiday.position().left-move)
		setTimeout (->
			$this.removeAttr("disabled");
		), 350;

	$(".slider_items."+cont+" .left").click (ev) ->
		ev.preventDefault();
		$this = $(this);
		$holiday = $("#"+cont+"_cont");
		this.disabled = "disabled";
		if($holiday.position().left < 0)
			$holiday.css("left", $holiday.position().left+move) 
		setTimeout (->
			$this.removeAttr("disabled");
		), 350;

compartir = (link, imagen) ->
	console.log link, imagen
	FB.ui({
	   method: 'feed',
    name: 'Mi Wishlist 2013',
    link: link+"",
    picture: imagen+"",
    caption: 'By Sephora',
    description: 'Este producto de Sephora ¡me encanta!'
	}, (response) ->
		if response && response.post_id
		else
	);


#-
#- Main Script
#-

initSlide("wishlist", 660)
initSlide("holiday", 660)
initSlide("roller", 329)
initSlide("maquillaje", 329)
initSlide("skincare", 329)
initSlide("cabello", 329)
initSlide("fra_mujer", 329)
initSlide("fra_hombre", 329)


$(".bottones.howto").click ->
  $(".box.participar").addClass("visible");
  $("#box").addClass("visible");

$(".bottones.prices").click ->
  $(".box.premios").addClass("visible");
  $("#box").addClass("visible");

$(".box .cerrar").click ->
  $(this).parent().removeClass("visible");
  $("#box").removeClass("visible");


$(".producto-compartir").click (ev) ->
	este = this;
	ev.preventDefault();
	ev.stopPropagation();
	li = $(este).parent();
	link =  $(li).find("a.producto-link").attr("href");
	imagen =  $(li).find("img.producto-img").attr("src");
	compartir(link, imagen)



$(".producto-agregar").click (ev) ->
	este = this;
	ev.preventDefault();
	ev.stopPropagation();
	$li = $(este).parent();

	if wishlist_cont < 5
		wishlist_cont++
		clonar = $li.clone();

		$("#wishlist_cont ul").append(clonar);
		setTimeout (->
			$(clonar).addClass("visible");
		), 50;

		$(clonar).find(".remover").click (ev2) ->
			remover = this;
			ev2.preventDefault();
			ev2.stopPropagation();
			$(clonar).addClass("fade-out")
			wishlist_cont--
			setTimeout (->
				$(remover).parent().remove();
			), 450;
	else
		$(".box.full").addClass("visible");
		$("#box").addClass("visible");
