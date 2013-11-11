# = require jquery
# = require_tree .

Init = ->
  $(".bottones.howto").click ->
    $(".box.participar").addClass("visible");

  $(".bottones.prices").click ->
    $(".box.premios").addClass("visible");

  $(".box .cerrar").click ->
    $(this).parent().removeClass("visible");

i = new Init();