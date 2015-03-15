# 一覧・検索画面
# posters/index.html
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