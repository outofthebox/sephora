# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# = require jquery
# = require jquery.urlshortener



# Inicializador

$(document).ready ->
	jQuery.urlShortener.settings.apiKey = 'AIzaSyAwvORpxsdPhnJhP5ZNb1IVa6lq-oyH3XQ';
	$ppal = $("#view");
	le_switch = $ppal[0].getAttribute("vista");
	console.log le_switch
	call_action(le_switch)


# Manejador de vista
call_action = (valor) ->
	switch valor
		when "show"
			call_show()


# Funciones por Vista
call_show = ->
	$gauge = $(".div_gauge");
	post_img = $(".post_img").attr("src");
	post_title = $(".post_title").text();
	post_title = post_title.replace(/(\r\n|\n|\r)/gm,""); #retorno de new line
	post_title = post_title.replace(/(\t\t|\s\s)/gm,""); #espacios inecesarios
	post_title = post_title.replace(/(&)/gm,"y"); #caracteres especiales
	post_extracto = $(".post_extracto").val();
	post_url = window.location.href;

	jQuery.urlShortener
		longUrl: post_url
		success: (shortUrl) ->
			console.log shortUrl
			post_url = shortUrl.id
		error: (err) ->
		  console.log err

	
	$(".btn-estrella").hover(
		(->
			$this = $(this);
			ancho = $this.outerWidth();
			raiting = $this.attr("raiting")
			gau_width = ancho * raiting;
			$gauge.width(gau_width);
		),
		(->
			$gauge.width(0); 
		)
	)
	
	fb_share = ->
		FB.ui({
			method: 'feed',
			name: post_title,
			link: window.location.href,
			picture: post_img,
			caption: "Sephora Blog!",
			description: post_extracto
		}, (post) ->
			if post
				console.log post
		);

	gp_share = ->
		width = 575
		height = 400
		left = ($(window).width() - width) / 2
		top = ($(window).height() - height) / 2
		params = 'text='+encodeURI(post_title)+'&via=SephoraMx';
		params += "&url="+post_url;
		url = "https://plus.google.com/share?";
		url += params;
		opts = "status=1" + ",width=" + width + ",height=" + height + ",top=" + top + ",left=" + left
		window.open url, "Google", opts
		false

	tw_share = ->
		width = 575
		height = 400
		left = ($(window).width() - width) / 2
		top = ($(window).height() - height) / 2
		params = 'text='+encodeURI(post_title);
		params += "&url="+post_url;
		url = "https://twitter.com/share?";
		url += params;
		opts = "status=1" + ",width=" + width + ",height=" + height + ",top=" + top + ",left=" + left
		window.open url, "Twitter", opts
		false

	pt_share = ->
		width = 575
		height = 400
		left = ($(window).width() - width) / 2
		top = ($(window).height() - height) / 2
		params = 'description='+encodeURI(post_title);
		params += "&url="+post_url;
		params += "&media="+post_img;
		url = "http://pinterest.com/pin/create/button/?";
		url += params;
		opts = "status=1" + ",width=" + width + ",height=" + height + ",top=" + top + ",left=" + left
		window.open url, "Pinterest", opts
		false

	
	$(".fb_share").click (ev) -> 
		ev.preventDefault();
		ev.stopPropagation();
		fb_share()

	$(".tw_share").click (ev) ->
		ev.preventDefault();
		ev.stopPropagation();
		tw_share();

	$(".gp_share").click (ev) ->
		ev.preventDefault();
		ev.stopPropagation();
		gp_share();

	$(".pt_share").click (ev) ->
		ev.preventDefault();
		ev.stopPropagation();
		pt_share();

