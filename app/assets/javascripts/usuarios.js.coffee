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
        if($holiday.position().left >= -2960)
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
    constructor: () ->
      ((d, s, id) ->
        js = undefined
        fjs = d.getElementsByTagName(s)[0]
        return  if d.getElementById(id)
        js = d.createElement(s)
        js.id = id
        js.src = "//connect.facebook.net/es_LA/all.js#xfbml=1&appId=424407284355166";
        fjs.parentNode.insertBefore js, fjs
      ) document, "script", "facebook-jssdk"

      $("#modal .close").click ->
        $(this).parent().addClass("hidden")

      $(".modal_buttons .btn-cerrar").click ->
        $("#modal .close").click()

      $(".preguntas_frecuentes").click ->
        $("#modal").removeClass("hidden")

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
    sharelist: ->
      post_title = $("meta[property='og:title']").attr("content")
      post_img = $("meta[property='og:image']").attr("content")
      post_link = $("meta[property='og:url']").attr("content")
      post_desc = $("meta[name='DC.Subject']").attr("content")
      
      fb_share = ->
        FB.ui({
          method: 'feed',
          name: post_title,
          link: post_link,
          picture: post_img,
          caption: "Sephora Wishlist!",
          description: post_desc
        }, (post) ->
          if post
            console.log post
        );

      gp_share = ->
        width = 575
        height = 400
        left = ($(window).width() - width) / 2
        top = ($(window).height() - height) / 2
        params = 'text='+encodeURI(post_desc)+'&via=SephoraMx';
        params += "&url="+post_link;
        url = "https://plus.google.com/share?";
        url += params;
        opts = "status=1" + ",width=" + width + ",height=" + height + ",top=" + top + ",left=" + left
        window.open url, "Google", opts
        false

      tw_share = ->
        width = 575
        height = 400
        left = ($(window).width() - width) / 2
        top = ($(window).height() - height) / 2
        params = 'text='+encodeURI(post_desc);
        params += "&url="+post_link;
        url = "https://twitter.com/share?";
        url += params;
        opts = "status=1" + ",width=" + width + ",height=" + height + ",top=" + top + ",left=" + left
        window.open url, "Twitter", opts
        false

      pt_share = ->
        width = 575
        height = 400
        left = ($(window).width() - width) / 2
        top = ($(window).height() - height) / 2
        params = 'description='+encodeURI(post_desc);
        params += "&url="+post_link;
        params += "&media="+post_img;
        url = "http://pinterest.com/pin/create/button/?";
        url += params;
        opts = "status=1" + ",width=" + width + ",height=" + height + ",top=" + top + ",left=" + left
        window.open url, "Pinterest", opts
        false

      
      $(".rs.fb").click (ev) -> 
        ev.preventDefault();
        ev.stopPropagation();
        fb_share()

      $(".rs.tw").click (ev) ->
        ev.preventDefault();
        ev.stopPropagation();
        tw_share();

      $(".rs.gplus").click (ev) ->
        ev.preventDefault();
        ev.stopPropagation();
        gp_share();

      $(".rs.pinterest").click (ev) ->
        ev.preventDefault();
        ev.stopPropagation();
        pt_share();
    open_faq: ->
      console.log(1)