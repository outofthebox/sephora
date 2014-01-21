# = require jquery
# = require jquery_ujs
# = require responsiveslides.min.js
# = require jquery.touchslider.min.js

$("#suscripcion_sus").click ->
  if $(this).is(":checked")
    $("#send").removeAttr "disabled"
  else
    $("#send").attr "disabled", "disabled"
$ ->
  $("#slider4").responsiveSlides
    auto: false
    timeout: 10000
    pager: false
    nav: true
    speed: 500
    namespace: "callbacks"
    before: ->
      $(".events").append "<li>before event fired.</li>"

    after: ->
      $(".events").append "<li>after event fired.</li>"

$ ->
  $("#lista ul").hide()
  $("#lista li").click (event) ->
    desplegable = $(this).next()
    $("#lista ul").not(desplegable).slideUp "fast"
    desplegable.slideToggle "fast"
    event.preventDefault()

$("#pollo p").each (index) ->
  $(this).hide()  unless $(this).text().trim().length

$("#pollo h4").each (index) ->
  $(this).hide()  unless $(this).text().trim().length

$ ->
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

jQuery ($) ->
  $(".touchslider").touchSlider mouseTouch: true