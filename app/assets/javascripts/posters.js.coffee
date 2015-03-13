# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
	$("#category").change ->
		set_url()
	$("#keyword").change ->
		set_url()
	set_url = ->
		server = $("#server").val()
		category = $("#category").val()
		keyword = $("#keyword").val()
		if keyword.length == 0
			keyword = "all"
		url = "/posters/#{server}/#{category}/#{keyword}"
		$("#search").attr("href", url)