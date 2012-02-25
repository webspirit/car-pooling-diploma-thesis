(function() {

// Defining some global variables
var map, geocoder, marker, infowindow;

window.onload = function() {
// Creating a new map
var options = {
zoom: 3,
center: new google.maps.LatLng(37.09, -95.71),
mapTypeId: google.maps.MapTypeId.ROADMAP
};

map = new google.maps.Map(document.getElementById('map'), options);
// Code for catching the form submit event goes here
}



function getArrCoordinates(address) {
	if(!geocoder) {
		geocoder = new google.maps.Geocoder();
	}
	
	var geocoderRequest = {
		address: address
	}

	geocoder.geocode(geocoderRequest, function(results, status) {
		if (status == google.maps.GeocoderStatus.OK) {
			map.setCenter(results[0].geometry.location);
			if (!marker) {
				marker = new google.maps.Marker({
					map: map
				});
			}
		marker.setPosition(results[0].geometry.location);
		$("#point_arrival_lat").val(results[0].geometry.location.lat());
 		$("#point_arrival_lng").val(results[0].geometry.location.lng());	
		}
	});
}

function getDepCoordinates(address) {
	if(!geocoder) {
		geocoder = new google.maps.Geocoder();
	}
	
	var geocoderRequest = {
		address: address
	}

	geocoder.geocode(geocoderRequest, function(results, status) {
		if (status == google.maps.GeocoderStatus.OK) {
			map.setCenter(results[0].geometry.location);
			if (!marker) {
				marker = new google.maps.Marker({
					map: map
				});
			}
		marker.setPosition(results[0].geometry.location);
		$("#point_departure_lat").val(results[0].geometry.location.lat());
 		$("#point_departure_lng").val(results[0].geometry.location.lng());

		}
	});


}



$(function() {
	$("#point_departure_address").blur(function() {
		get_dep_address();
	});	
	
	$("#point_arrival_address").blur(function() {
		get_arr_address();
	});	
});

	function get_dep_address() {
		var dep_address = $("#point_departure_address").val();
		getDepCoordinates(dep_address);
	}
	
	function get_arr_address() {
		var arr_address = $("#point_arrival_address").val();
		getArrCoordinates(arr_address);
	}
	
})();