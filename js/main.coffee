$ ->
	mapOptions =
		center: new google.maps.LatLng(-34.397, 150.644),
		zoom: 8,
		mapTypeId: google.maps.MapTypeId.ROADMAP
	map = new google.maps.Map($("#map_canvas").get(0), mapOptions);