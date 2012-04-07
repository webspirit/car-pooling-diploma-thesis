(function() {

// Defining some global variables
var map1, geocoder1, marker1;

window.onload = function() {
// Creating a new map
var options = {
zoom: 16,
center: new google.maps.LatLng(37.9743323, 23.7330191),
mapTypeId: google.maps.MapTypeId.ROADMAP
};

dep_map = new google.maps.Map(document.getElementById('dep_map'), options);
arr_map = new google.maps.Map(document.getElementById('arr_map'), options);
}







function getDepCoordinates(address) {
	if(!geocoder1) {
		geocoder1 = new google.maps.Geocoder();
	}
	
	var geocoderRequest1 = {
		address: address
	}


	geocoder1.geocode(geocoderRequest1, function(results, status) {
		if (status == google.maps.GeocoderStatus.OK) {
			dep_map.setCenter(results[0].geometry.location);
			dep_map.setZoom(16);
			if (!marker1) {
				marker1 = new google.maps.Marker({
					map: dep_map
				});
			}
		marker1.setPosition(results[0].geometry.location);
		


		$("#route_departure_lat").val(results[0].geometry.location.lat());
 		$("#route_departure_lng").val(results[0].geometry.location.lng());

		}
	});


}



$(function() {
	$("#route_departure_address").blur(function() {
		get_dep_address();
	});	
});


	function get_dep_address() {
		var dep_address = $("#route_departure_address").val();
		getDepCoordinates(dep_address);
	}	
})();



















(function() {
	
	var map2, geocoder2, marker2;

function getArrCoordinates(address) {
	if(!geocoder2) {
		geocoder2 = new google.maps.Geocoder();
	}
	
	var geocoderRequest2 = {
		address: address
	}

		
	geocoder2.geocode(geocoderRequest2, function(results, status) {
		if (status == google.maps.GeocoderStatus.OK) {
			arr_map.setCenter(results[0].geometry.location);
			arr_map.setZoom(16);
			if (!marker2) {
				marker2 = new google.maps.Marker({
					map: arr_map
				});
			}
		marker2.setPosition(results[0].geometry.location);
		
		$("#route_arrival_lat").val(results[0].geometry.location.lat());
 		$("#route_arrival_lng").val(results[0].geometry.location.lng());	
		}
	});
}




$(function() {
	
	$("#route_arrival_address").blur(function() {
		get_arr_address();
	});	
});

	function get_arr_address() {
		var arr_address = $("#route_arrival_address").val();
		getArrCoordinates(arr_address);
	}
	
})();














