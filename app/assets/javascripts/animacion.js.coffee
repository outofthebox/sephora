# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#=require modernizr2

window.Animacion ||= {}

class Animacion.slider
  constructor: ->
    app = @
    app.animated = false
    $(".navigation.previous").click (e) ->
      e.preventDefault();
      app.move_left();

    $(".navigation.next").click (e) ->
      e.preventDefault();
      app.move_right();

  move_right: ->
    app = @
    carousel = $(".productos")

    producto = $(".producto")
    producto_count = producto.length
    producto_width = producto.width()

    max_size = (producto_count-1) * producto_width

    left = carousel.position().left

    if max_size > Math.abs(left) && app.animated == false
      app.animated = true
      setTimeout ->
        app.animated = false
      , 250
      left -= producto_width
      $(".productos").css('left', left)

  move_left: ->
    app = @
    producto = $(".producto")
    producto_count = producto.length
    producto_width = producto.width()

    max_size = (producto_count-1) * producto_width

    left = $(".productos").position().left

    if max_size >= Math.abs(left) && left < 0 && app.animated == false
      app.animated = true
      setTimeout ->
        app.animated = false
      , 250
      left += producto_width
      $(".productos").css('left', left)
      app.animated = true