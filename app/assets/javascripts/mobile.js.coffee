# = require jquery
# = require jquery_ujs
# = require responsiveslides.min.js

$("#suscripcion_sus").click ->
  if $(this).is(":checked")
    $("#send").removeAttr "disabled"
  else
    $("#send").attr "disabled", "disabled"
$ ->
  $("#slider4").responsiveSlides
    auto: true
    timeout: 10000
    pager: false
    nav: true
    speed: 500
    namespace: "callbacks"
    before: ->
      $(".events").append "<li>before event fired.</li>"

    after: ->
      $(".events").append "<li>after event fired.</li>"
