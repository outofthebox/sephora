# = require jquery
# = require jquery_ujs
# = require_tree .

Init = ->
  App = this
  App.header = document.getElementById("header");
  App.main = document.getElementById("main");
  App.contenido = document.getElementById("contenido");
  App.footer = document.getElementById("footer");

  $(".bottones.howto").click ->
    $(".box.participar").addClass("visible");

  $(".bottones.prices").click ->
    $(".box.premios").addClass("visible");

  $(".box .cerrar").click ->
    $(this).parent().removeClass("visible");


Init::picker = (callback) ->
  App = this
  App.store ->
  enCaso = App.main.getAttribute("pagina");
  switch enCaso
    when "home"
      $(window).load ->

i = new Init();