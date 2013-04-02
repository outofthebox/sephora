# = require jquery
# = require jquery_ujs
$(document).on "click", "a#share", (e) ->
  loc = undefined
  title = undefined
  e.preventDefault()
  loc = $(this).attr("href")
  title = escape($(this).attr("title"))
  window.open "http://www.facebook.com/sharer.php?u=" + loc + "&t=" + title, "facebookwindow", "height=450, width=550, top=" + ($(window).height() / 2 - 225) + ", left=" + $(window).width() / 2 + ", toolbar=0, location=0, menubar=0, directories=0, scrollbars=0"
