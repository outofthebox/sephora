# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#=require jquery
#=require jquery-ui
#=require jquery_ujs
#=require bootstrap-sprockets
#=require jquery.ddslick.min.js


$(document).ready( ->
	picker()
);

picker = ->
	enCaso = $("#main").attr("vista");
	switch enCaso
		when "landing_new"
			$("#marcas").ddslick 
				onSelected: (data) ->
					$("#landing_marca_id").val(data.selectedData.value)