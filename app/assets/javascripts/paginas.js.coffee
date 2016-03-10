#= require countdown
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

  class Paginas.Opening
    init_timer: ->
      countdown.resetLabels();
      countdown.setLabels(
        ' milisegundo| segundo| minuto| hora| dia| semana| mes| año| década| século| milenio',
        ' milisegundos| segundos| minutos| horas| dias| semanas| meses| años| décadas| séculos| milenios',
        "", "", "00",
        (n) ->
          real_n = if n < 10 then '0' + n.toString() else n.toString()
          return real_n
      );
      timerId = countdown(
        new Date(2016, 2, 17, 18, 0, 0, 0),
        ((ts) ->
          elements = ts.toHTML('strong').replace(/(milisegundos|segundos|minutos|horas|dias|semanas|meses|años|décadas|séculos|milenios|milisegundo|segundo|minuto|hora|dia|semana|mes|año|década|século|milenio)/ig, "<span>$1</span>").trim()
          document.getElementById('pageTimer').innerHTML = elements
        ),
        countdown.DAYS | countdown.HOURS | countdown.MINUTES | countdown.SECONDS
      )
      return timerId

      fill_empty = (strin) ->
        strong_count = $('#pageTimer').find('strong').length
        while(strong_count < 4)
          $('#pageTimer').prepend("<strong>00</strong>")
          strong_count = $('#pageTimer').find('strong').length
