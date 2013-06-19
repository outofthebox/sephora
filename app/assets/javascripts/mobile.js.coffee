# = require jquery
# = require jquery_ujs
$("#suscripcion_sus").click ->
  if $(this).is(":checked")
    $("#send").removeAttr "disabled"
  else
    $("#send").attr "disabled", "disabled"
