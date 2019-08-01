// Creating map object


// Adding tile layer to the map
var graymap = L.tileLayer("https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}", {
  attribution: "Map data &copy; <a href='https://www.openstreetmap.org/'>OpenStreetMap</a> contributors, <a href=https://creativecommons.org/licenses/by-sa/2.0/'>CC-BY-SA</a>, Imagery © <a href='https://www.mapbox.com/'>Mapbox</a>",
  maxZoom: 18,
  id: "mapbox.streets",
  accessToken: "pk.eyJ1IjoiZHJld3J1c3NlbGwiLCJhIjoiY2p4MTViOXV5MDU2NjQzbDNqMWhhcjNpcCJ9.POqSMOBeH9TYyfxdOMCp4w"
});

var myMap = L.map("mapid", {
  center: [40.7, -94.5],
  zoom: 3
});

graymap.addTo(myMap);

d3.json("https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_week.geojson", function(data) {

	function styleInfo(feature) {
		return{
		opacity:1,
		fillopacity: 1,
		fillcolor: getcolor(feature.properties.mag),
		color: "#000000",
		radius: getradius(feature.properties.mag),
		stroke: true,
		weight: 0.5};
	}

	function getcolor(magnitude) {
		switch(true){
			case mag > 5:
				return "#ea2c2c";
			case mag > 4:
				return "#ea822c";
			case mag > 3:
				return "#ea9c00";
			case mag > 2:
				return "#eecc00";
			case mag > 1:
				return "#d4ee00";
			default:
				return "#98ee00"; 
		}}
	function getradius(magnitude) {
		if(magnitude===0){
			return 1;}
			return magnitude * 4;}
			
L.geoJSON(data, {
    pointToLayer: function (feature, latlng) {
        return L.circleMarker(latlng);
    }
}).addTo(myMap);
});	