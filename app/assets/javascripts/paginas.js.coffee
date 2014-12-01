$ ->
  window.Paginas ||= {}

  class Paginas.Index
    start_slider: (direction = null) ->
    	$prox = $(".prox");
    	$ante = $(".ante");

    	slide_me = ->
        $current = $(".diapositiva.visible");
        if direction == "left"
        	if $current.before().size() > 0
	          $current.removeClass("visible").before().addClass("visible")
	        else
	          $next = $(".diapositiva").last()
	          $current.removeClass("visible")
	          $next.addClass("visible")
        else
	        if $current.next().size() > 0
	          $current.removeClass("visible").next().addClass("visible")
	        else
	          $next = $(".diapositiva.first").first()
	          $current.removeClass("visible")
	          $next.addClass("visible")

      $prox.click ->
      	slide_me()

	    $ante.click ->
      	slide_me("left")

      
      intervalo = setInterval(->
        slide_me()
      , 5000)
