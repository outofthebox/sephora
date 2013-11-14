# = require jquery

#-
#- Declaracion de funciones
#-
initSlide = (cont, move) ->
	console.log cont+" .left", $(cont+" .left")
	$(".slider_items."+cont+" .left").click (ev) ->
		ev.preventDefault();
		$this = $(this);
		this.disabled = "disabled";
		$holiday = $("#"+cont+"_cont");
		if($holiday.position().left >= -1020)
			$holiday.css("left", $holiday.position().left-move)
		setTimeout (->
			$this.removeAttr("disabled");
		), 350;

	$(".slider_items."+cont+" .right").click (ev) ->
		ev.preventDefault();
		$this = $(this);
		$holiday = $("#"+cont+"_cont");
		this.disabled = "disabled";
		if($holiday.position().left < 0)
			$holiday.css("left", $holiday.position().left+move) 
		setTimeout (->
			$this.removeAttr("disabled");
		), 350;




initSlide("wishlist", 660)
initSlide("holiday", 660)
initSlide("roller", 329)
initSlide("maquillaje", 329)
initSlide("skincare", 329)
initSlide("cabello", 329)
initSlide("fra_mujer", 329)
initSlide("fra_hombre", 329)