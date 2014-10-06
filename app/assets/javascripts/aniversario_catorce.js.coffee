# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#= require jquery
#= require jquery-ui
#= require jquery.cookie
#= require flipclock

$ ->
  window.AniversarioCatorce ||= {}

  class AniversarioCatorce.Vip
    soy_vip: ->
      $("*").click (ev) ->
        ev.preventDefault()
        ev.stopPropagation()

  class AniversarioCatorce.BeautyTrip
    start: () ->
      aniv = @
      aniv.data = []
      $visible = $(".trivia_slide.visible");
      $next = $visible.next(".trivia_slide");
      $respuestas = $(".trivia_slide .respuestas li");

      $respuestas.click (ev) ->
        ev.preventDefault()
        ev.stopPropagation()
        $this = $(this);
        
        id = $this.attr("id");

        $respuestas.each (i,li) ->
          $(li).removeClass("pulse")

        $this.addClass("pulse")
        $visible.addClass("fadeOut").removeClass("visible");
        $next.addClass("visible")
        
        $visible = $next;
        $next = $visible.next(".trivia_slide");
        m = {id: $this.attr("p_id"), pregunta: $this.attr("pregunta"), opcion: $this.attr("opcion"), respuesta: $this.attr("respuesta")}
        
        aniv.add_respuesta m

        console.log "next?", $next.size(), $next
        if $next.size() == 0
          $.each aniv.data, (i, p) ->
            tr = document.createElement("tr")
            
            p_id = document.createElement("td")
            p_id.appendChild(document.createTextNode(p.id))

            pregunta = document.createElement("td")
            pregunta.appendChild(document.createTextNode(p.pregunta))

            opcion = document.createElement("td")
            opcion.appendChild(document.createTextNode(p.opcion))

            respuesta = document.createElement("td")
            respuesta.appendChild(document.createTextNode(p.respuesta))

            tr.appendChild(p_id)
            tr.appendChild(pregunta)
            tr.appendChild(opcion)
            tr.appendChild(respuesta)

            $("#respuestas_usuario tbody").append(tr)

      $("btn.submit").click (ev) ->
        ev.preventDefault()
        ev.stopPropagation()

        $.post "/aniversario_catorce/beauty_trip/finish", {data: aniv.data}, (data) ->
          if data && data.error != true
            $visible.removeClass("visible")
            $("#guardado").addClass("visible")

    add_respuesta: (m) ->
      aniv = @
      aniv.data.push(m)
      console.log aniv.data

  class AniversarioCatorce.Teaser
    console.log("miau")



        
