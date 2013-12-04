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
    js.src = "//connect.facebook.net/es_LA/all.js#xfbml=1&appId=424407284355166";
    fjs.parentNode.insertBefore js, fjs
  ) document, "script", "facebook-jssdk"

window.fbAsyncInit = ->
	#fb_login()

#-
#- Declaracion de variables
#-

wishlist_cont = 0;
upc = [];

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
	FB.ui({
	   method: 'feed',
    name: '¡Mira este producto de mi Wishlist Navideño!',
    link: "http://sephora.com.mx/"+link,
    picture: imagen,
    caption: 'Sephora México',
    description: 'Este es mi producto favorito. Descubre el Wishlist de Sephora México y crea también el tuyo.'
	}, (response) ->
		if response && response.post_id
		else
	);

fb_salvar = ->
	FB.login ((response) ->
    if response.authResponse
    	FB.api("/me", (usuario) ->
    		if usuario && !usuario.error
    			compartirWishlist usuario.id, (post) ->
	    			loc_str = "/wishlist/nuevo/"
	    			loc_str += usuario.id+"/"
	    			loc_str += post.id+"/"
	    			$.each upc, (index, str) ->
	    				loc_str += str+"/"
	    			window.location = loc_str
    	)
    else
    	console.log ""
  ),
  scope: "email,read_stream,publish_stream"

fb_salvard = ->
	loc_str = "/wishlist/nuevo/gessgallardo/1/1/"
	$.each upc, (index, str) ->
    loc_str += str+"/"

  window.location  = loc_str;

compartirWishlist = (username) ->
	FB.ui({
	   method: 'feed',
    name: '¿No sabes qué regalarme en Navidad? Mira mi wishlist.',
    link: "https://apps.facebook.com/wishlistsephora/ver/"+username,
    picture: 'http://sephora.com.mx/assets/holiday/2013/logo-b05b7169d63ec88212dc1e469ae34ad4.png',
    caption: 'Mi wishlist de Sephora México',
    description: '!Haz click y crea tambien la tuya para ganar un Holiday Kit!'
	}, (response) ->
		if response
			return response
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


$(".bottones.add_wish").click ->
	fb_salvar()

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
	str_upc = $li.attr("data-upc");

	if wishlist_cont < 5
		wishlist_cont++
		
		upc.push(str_upc);
		
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

			$.each upc, (index, str) ->
				upc.splice(index, 1) if str is str_upc

			setTimeout (->
				$(remover).parent().remove();
			), 450;
	else
		$(".box.full").addClass("visible");
		$("#box").addClass("visible");