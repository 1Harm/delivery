import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:deliveat/domain/Models/map_marker_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:deliveat/domain/Constants/app_constants.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with TickerProviderStateMixin {
  final pageController = PageController();
  int selectedIndex = 0;
  var currentLocation = AppConstants.myLocation;

  late final MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: latLng.LatLng(51.089864, 71.416761),
              zoom: 14.0,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    'https://api.mapbox.com/styles/v1/lehus13/clcyhcne4014814s1es11blg6/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibGVodXMxMyIsImEiOiJjbGN5aDdpZWkwc3dtM3JwN2FmNmtwOXl0In0.xh2HwkgUcGNgNqAGsuHbEA',
                additionalOptions: {
                  'access token':
                      'pk.eyJ1IjoibGVodXMxMyIsImEiOiJjbGN5aDdpZWkwc3dtM3JwN2FmNmtwOXl0In0.xh2HwkgUcGNgNqAGsuHbEA',
                  'id': 'mapbox.mapbox-streets-v8',
                },
              ),
              MarkerLayerOptions(
                markers: [
                  for (int i = 0; i < mapMarkers.length; i++)
                    Marker(
                      height: 40,
                      width: 40,
                      point: mapMarkers[i].location ?? AppConstants.myLocation,
                      builder: (_) {
                        return GestureDetector(
                          onTap: () {
                            pageController.animateToPage(
                              i,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                            selectedIndex = i;
                            currentLocation = mapMarkers[i].location ??
                                AppConstants.myLocation;
                            _animatedMapMove(currentLocation, 11.5);
                            setState(() {});
                          },
                          child: SvgPicture.asset(
                            'assets/icons/map_marker.svg',
                          ),
                        );
                      },
                    ),
                ],
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 2,
            height: MediaQuery.of(context).size.height * 0.3,
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (value) {
                selectedIndex = value;
                currentLocation =
                    mapMarkers[value].location ?? AppConstants.myLocation;
                _animatedMapMove(currentLocation, 11.5);
                setState(() {});
              },
              itemCount: mapMarkers.length,
              itemBuilder: (_, index) {
                final item = mapMarkers[index];
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: item.rating,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return const Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                    );
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title ?? '',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      item.address ?? '',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                item.image ?? '',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _animatedMapMove(latLng.LatLng destLocation, double destZoom) {
    final latTween = Tween<double>(
        begin: mapController.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: mapController.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: mapController.zoom, end: destZoom);

    var controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapController.move(
        latLng.LatLng(
            latTween.evaluate(animation), lngTween.evaluate(animation)),
        zoomTween.evaluate(animation),
      );
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }
}
