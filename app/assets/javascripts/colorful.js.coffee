# = require jquery
# = require jquery_ujs
# = require tubular
$(document).ready ->
  $("#quiz").on "click", (e) ->
    e.preventDefault()
    $("#cuestionario").show()

  $("ul.productos li a").hover (->
    big_image = $(this).data('big')
    title = $(this).data('name').replace('Colorful Mono', '')
    $("#big_image").html('').append('<img src='+big_image+' width=180 /><h3>'+title+'</h3>').css('opacity', 1)
  ), ->
    $("#big_image").css('opacity', 0)

  if window.location.pathname == "/colorful"
    $("#video").tubular
      videoId: "O6caGBinOnQ"
      mute: false
      repeat: false
  else
    $("#video").hide()
    $("#colorful").fadeIn()

  findthat = (arr) ->
    uniqs = {}
    i = 0

    while i < arr.length
      uniqs[arr[i]] = (uniqs[arr[i]] or 0) + 1
      i++
    max =
      val: arr[0]
      count: 1

    for u of uniqs
      if max.count < uniqs[u]
        max =
          val: u
          count: uniqs[u]
    max.val
  $("#cuestionario li").first().show()
  valores = new Array()
  $("#cuestionario li p").on "click", ->
    $(this).parent("li").hide()
    valores.push $(this).find("input").val()
    unless $(this).parent("li").is(":last-child")
      $(this).parent("li").next("li").show()
    else
      $("#cuestionario").fadeOut()
      personalidad = findthat(valores)
      switch personalidad
        when "0"
          location.href = '/colorful/hipster'
        when "1"
          location.href = '/colorful/rocker'
        when "2"
          location.href = '/colorful/chic'
        when "3"
          location.href = '/colorful/junkie'

