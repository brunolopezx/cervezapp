import 'package:google_maps_flutter/google_maps_flutter.dart';

patioOlmos() {
  return LatLng(-31.4198437397304, -64.18832917121607);
}

Set<Marker> createMarker() {
  return {
    Marker(
        markerId: MarkerId("Vidón"),
        position: LatLng(-31.424850603282888, -64.18993104187368),
        infoWindow: InfoWindow(title: 'Vidón Bar')),
    Marker(
        markerId: MarkerId("Canario"),
        position: LatLng(-31.422527789369205, -64.18447011307684),
        infoWindow: InfoWindow(title: "Canario")),
    Marker(
        markerId: MarkerId("Terminal"),
        position: LatLng(-31.427281517279994, -64.19137810891324),
        infoWindow: InfoWindow(title: "La Terminal")),
    Marker(
        markerId: MarkerId("Barbeer"),
        position: LatLng(-31.421233895702816, -64.18811933973387),
        infoWindow: InfoWindow(title: "The BarBeer")),
    Marker(
        markerId: MarkerId("Gloton"),
        position: LatLng(-31.42320512169598, -64.19127932222135),
        infoWindow: InfoWindow(title: "Glotón")),
  };
}
