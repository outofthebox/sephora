
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
# = require jquery
# = require bootstrap
# = require responsiveslides.min.js
# = require jquery.touchslider.min.js

$(document).ready ->
  vista = $("#main").attr("vista");
  do_select(vista)

do_select = (vista) ->
  switch vista
    when "lonuevo"
      do_lonuevo();
    when "hotnow"
      do_hotnow();
    when "beauty"
      do_beauty();
    when "videos"
      do_videos();
    when "especialesmes"
      do_especialesmes();

do_especialesmes = ->
  text = "¡Felicidades!\n\nPresenta este codigo en la tienda para reclamar tu case de sephora\n\n Codigo: "
  uni = $("#unique").val();
  console.log typeof uni
  if(uni != null && uni != "" && uni != " ")
    alert(text+uni);

do_lonuevo = ->
  jQuery ($) ->
    $(".touchslider").touchSlider mouseTouch: true

do_hotnow = ->
  jQuery ($) ->
    $(".touchslider").touchSlider mouseTouch: true    
  
do_beauty = ->
  $("#lista ul").hide();
  $("#lista li.cabecera").click (event) ->
    desplegable = $(this).find(".contenido");
    $("#lista ul.contenido").not(desplegable).slideUp "fast"
    desplegable.slideToggle "fast"
    event.preventDefault()

do_videos = ->
  commafy = (arg) ->
    arg += ""
    num = arg.split(".")
    if typeof num[0] isnt "undefined"
      int = num[0]
      if int.length > 3
        int = int.split("").reverse().join("")
        int = int.replace(/(\d{3})/g, "$1,")
        int = int.split("").reverse().join("")
    if typeof num[1] isnt "undefined"
      dec = num[1]
      dec = dec.replace(/(\d{3})/g, "$1 ")  if dec.length > 4
    ((if typeof num[0] isnt "undefined" then int else "")) + ((if typeof num[1] isnt "undefined" then "." + dec else ""))
  
  htmlString = "<ul id=\"videoslisting\">"
  ytapiurl = "http://gdata.youtube.com/feeds/api/users/SephoraMex/uploads?alt=json&max-results=10"
  
  $.getJSON ytapiurl, (data) ->
    $.each data.feed.entry, (i, item) ->
      title = item["title"]["$t"]
      videoid = item["id"]["$t"]
      pubdate = item["published"]["$t"]
      fulldate = new Date(pubdate).toLocaleDateString()
      thumbimg = item["media$group"]["media$thumbnail"][0]["url"]
      tinyimg1 = item["media$group"]["media$thumbnail"][1]["url"]
      tinyimg2 = item["media$group"]["media$thumbnail"][2]["url"]
      tinyimg3 = item["media$group"]["media$thumbnail"][3]["url"]
      vlink = item["media$group"]["media$content"][0]["url"]
      ytlink = item["media$group"]["media$player"][0]["url"]
      numviews = item["yt$statistics"]["viewCount"]
      numcomms = item["gd$comments"]["gd$feedLink"]["countHint"]
      htmlString += "<li class=\"clearfix\">"
      htmlString += "<div class=\"videothumb\"><a href=\"" + ytlink + "\" target=\"_blank\"><img src=\"" + thumbimg + "\" width=\"97%\" height=\"97%\"></a></div>"
      htmlString += "<div class=\"title\"><h6>" + title.substring(0,40)+"..."+ "</h6>"

    $("#videos").html htmlString + "</ul>"
