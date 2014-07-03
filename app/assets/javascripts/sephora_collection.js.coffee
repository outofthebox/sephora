# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#= require jquery
#= require bootstrap


Init = ->
  App = this
  App.main = document.getElementById("vista");
  App.picker ->


Init::picker = (callback) ->
  App = this
  enCaso = App.main.getAttribute("vista");
  switch enCaso
    when "index"
    	setInterval(->
    		if($("#box-wrapper").hasClass("animate") == false)
    			$("#box-wrapper").addClass("animate carro_animation");
    		else
    			 $("#box-wrapper").toggleClass("carro_away");
    	, 8000);

i = new Init();


$(".tips_1").hover ->
  $(".flyout_1").fadeToggle()
  return
$(".tips_2").hover ->
  $(".flyout_2").fadeToggle()
  return
$(".tips_3").hover ->
  $(".flyout_3").fadeToggle()
  return

