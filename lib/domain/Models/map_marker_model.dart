import 'package:latlong2/latlong.dart';

class MapMarker {
  final String? image;
  final String? title;
  final String? address;
  final LatLng? location;
  final int? rating;

  MapMarker({
    required this.image,
    required this.title,
    required this.address,
    required this.location,
    required this.rating,
  });
}

final mapMarkers = [
  MapMarker(
      image: 'assets/images/restaurant_1.jpg',
      title: 'Alexander The Great Restaurant',
      address: '8 Plender St, London NW1 0JT, United Kingdom',
      location: LatLng(51.098909, 71.426986),
      rating: 4),
  MapMarker(
      image: 'assets/images/restaurant_2.jpg',
      title: 'Mestizo Mexican Restaurant',
      address: '103 Hampstead Rd, London NW1 3EL, United Kingdom',
      location: LatLng(51.099932, 71.414614),
      rating: 5),
  MapMarker(
      image: 'assets/images/restaurant_3.jpg',
      title: 'The Shed',
      address: '122 Palace Gardens Terrace, London W8 4RT, United Kingdom',
      location: LatLng(51.092538, 71.436234),
      rating: 2),
  MapMarker(
      image: 'assets/images/restaurant_4.jpg',
      title: 'Gaucho Tower Bridge',
      address: '2 More London Riverside, London SE1 2AP, United Kingdom',
      location: LatLng(51.113325, 71.424745),
      rating: 3),
  MapMarker(
    image: 'assets/images/restaurant_5.jpg',
    title: 'Bill\'s Holborn Restaurant',
    address: '42 Kingsway, London WC2B 6EY, United Kingdom',
    location: LatLng(51.105060, 71.380283),
    rating: 4,
  ),
];
