# = require jquery
# = require jquery_ujs
# = require tubular
# = require perfect-scrollbar.min.js

Init = ->
  App = this
  App.header = document.querySelector("header");
  App.main = document.getElementById("main");
  App.footer = document.querySelector("footer");
  App.picker ->


Init::picker = (callback) ->
  App = this
  enCaso = App.main.getAttribute("view");
  switch enCaso
    when "intro"
      $("#video").tubular
        videoId: "dPks1pJV0Xs"
        mute: true
        repeat: false

      $(window).load ->
        player.addEventListener 'onStateChange', (state) ->
          window.location = "/marc-jacobs-beauty/home" if state.data == 0

    when "home"
      $(window).load ->
        App.initBackground ->
        App.animateBackground 4000
        App.footer.className = "black";
        App.header.className = "black";
        $("#marcjacobs").addClass("marcVisible"); 
        $("#skipIntro").remove();
        App.resize();


    when "ojos","unas","labios","rostro","favoritos","look"
      $("#marcjacobs").addClass("marcVisible");
      $("#skipIntro").remove();
      App.footer.className = "white";
      App.header.className = "white";
        


Init::skipIntro = (callback) ->
    App = this
    player.stopVideo()
    player.clearVideo();
    $("#skipIntro").remove();
    $('#tubular-player').fadeOut 350, ->
      $("#tubular-shield").remove();
      $("#tubular-container").remove();
      $('#tubular-player').remove();

Init::resize = ->
  App = this
  main = document.querySelector("#main");

  $(main).height(App.getMainHeight())
  
  $(window).resize ->
    $(main).height(App.getMainHeight())

Init::getMainHeight = (callback) ->
  App = this
  w = window
  d = document
  e = d.documentElement
  g = d.getElementsByTagName("body")[0]
  x = w.innerWidth or e.clientWidth or g.clientWidth
  y = w.innerHeight or e.clientHeight or g.clientHeight

  size = $(window).height() - $(App.header).outerHeight() - $(App.footer).outerHeight();

  return size;

Init::initBackground = (callback) ->
  bg = document.querySelectorAll("#background div")
  i = 0
  len = bg.length

  while i < len
    img = bg[i]
    img.setAttribute "data-index", i
    i++
  callback()  if typeof callback is "function"

Init::animateBackground = (timeout) ->
  bg = document.querySelectorAll("#background div")
  index = 0
  if bg.length > 1
    setInterval (->
      nextIndex = index + 1
      $(bg[index]).removeClass("background-hidden").addClass "current"
      $(bg[nextIndex]).addClass("background-hidden").removeClass "current"
      if nextIndex is bg.length
        nextIndex = 0
        index = 0
      else
        index++
    ), timeout

i = new Init();