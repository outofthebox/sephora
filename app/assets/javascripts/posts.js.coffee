# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# =  require jquery

# Inicializador

$(document).ready ->
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
	