# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/



window.compartirFrase = (frase) ->
  FB.ui({
     method: 'feed',
    name: 'Share the Love',
    link: "http://www.sephora.com.mx/sharethelove"
    picture: frase,
    caption: 'SHARE THE LOVE',
    description: 'Nuestras holiday cards son para ti, tu bff, tu novio, tu hermana, o tu roomie ¡son para todos!'
  }, (post) ->
    console.log("post")
);

$(".phrase-card").click (ev) ->
  p = $(@).attr("src")
  compartirFrase("http://www.sephora.com.mx"+p)
  console.log(p)

