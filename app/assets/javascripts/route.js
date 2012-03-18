(function() {
	
	var map, directionsDisplay;
	var gdir = new google.maps.DirectionsService(); 
	
	
	   
	window.onload = function() {
		directionsDisplay = new google.maps.DirectionsRenderer();

		var options = {
			zoom : 15,
			center : new google.maps.LatLng(37.97534, 23.73615),
			mapTypeId : google.maps.MapTypeId.ROADMAP
		};

		map = new google.maps.Map(document.getElementById('route_map'), options);
		directionsDisplay.setMap(map);


		var start = $("#start").text();
	   	var end = $("#end").text();  	
		var request = {
			origin:start, 
		    destination:end,
		    travelMode: google.maps.DirectionsTravelMode.DRIVING
		}
		gdir.route(request, calcRoute);
	};
	
	function calcRoute(response, status) {
      if (status == google.maps.DirectionsStatus.OK) {
        //var directionsDisplay = new google.maps.DirectionsRenderer({map: map, panel: document.getElementById('mydir')});
        directionsDisplay.setDirections(response);
      }

	

  }
   	

})();
