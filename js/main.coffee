$ ->
	mapOptions =
		center: new google.maps.LatLng(-34.397, 150.644),
		zoom: 8,
		mapTypeId: google.maps.MapTypeId.ROADMAP
	map = new google.maps.Map $("#map_canvas").get(0), mapOptions
	
	infowindow = new google.maps.InfoWindow
	marker = new google.maps.Marker {map: map}

	autocomplete = new google.maps.places.Autocomplete $("#autocomplete").get(0), { types: ['geocode'] }
	google.maps.event.addListener autocomplete, 'place_changed', ->
		place = autocomplete.getPlace()
		if !place.geometry
			return
		if place.geometry.viewport
			map.fitBounds place.geometry.viewport
		else
			map.setCenter place.geometry.location
			map.setZoom 17
		
		infowindow.setContent $('<ul></ul>').get(0)
		
		service = new google.maps.places.PlacesService map
		request = { location: place.geometry.location, radius: 50, type: 'establishment' }
		service.nearbySearch request, (places, status, pagination) ->
			if status == google.maps.places.PlacesServiceStatus.OK
				marker.setIcon new google.maps.MarkerImage(place.icon, new google.maps.Size(70, 70), new google.maps.Point(0, 0), new google.maps.Point(17, 34), new google.maps.Size(35, 35))
				marker.setPosition place.geometry.location		
				for place in places
					service.getDetails { reference: place.reference }, (p, s) ->
						if s == google.maps.places.PlacesServiceStatus.OK
							infowindow.setContent $(infowindow.getContent()).append($('<li>' + p.name + '</li>').get(0)).get(0)
				infowindow.open map, marker