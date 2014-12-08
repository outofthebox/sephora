# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  window.Usuarios ||= {}

  class Usuarios.Wishlist
    initSlide: (cont, move) ->
      $(".slider_items."+cont+" .right").click (ev) ->
        ev.preventDefault();
        $this = $(this);
        this.disabled = "disabled";
        $holiday = $("#"+cont+"_cont");
        if($holiday.position().left >= -1020)
          $holiday.css("left", $holiday.position().left-move)
        setTimeout (->
          $this.removeAttr("disabled");
        ), 350;

      $(".slider_items."+cont+" .left").click (ev) ->
        ev.preventDefault();
        $this = $(this);
        $holiday = $("#"+cont+"_cont");
        this.disabled = "disabled";
        if($holiday.position().left < 0)
          $holiday.css("left", $holiday.position().left+move) 
        setTimeout (->
          $this.removeAttr("disabled");
        ), 350;
  
  class Usuarios.Userlist
    userlist: () ->
      $(".remover").click ->
        parent = $(this).parent()
        upc = parent.attr("data-upc");
        parent.fadeOut(800, ->
          $.post("/usuario/wishlist/del/"+upc, (data) ->
            if(data.status == "exito")
              parent.remove()
          )
        )
    add_to_userlist: ->
      $(".add_to_favs").click ->
        $this = $(this)
        leupc = $(this).attr("data-upc");
        $.post("/usuario/wishlist/add/"+leupc, (data) ->
          if(data.status == "exito")
            $this.addClass("animated hover infinite pulse")
        )
