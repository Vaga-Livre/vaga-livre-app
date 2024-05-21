import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../parks/controllers/parks_search_controller.dart';
import '../controller/map_controller.dart';

class MapWidget extends StatelessWidget {
  RelativeRect? lastTapPosition;

  MapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final mapController = context.watch<MapController>();
      final searchController = context.read<ParksSearchController>();
      return BlocBuilder<ParksSearchController, ParkSearchState>(
        builder: (context, state) {
          final Set<Marker> markers;

          switch (state) {
            case LoadingResults():
              markers = {};
            case MapViewParksResults(:final parksNearby):
              markers = Set.from(
                parksNearby.map((e) => _CustomMarker.park(e, () {})),
              );
            case ParksNearbyDestinationResults(:final parksNearby, :final destination):
              markers = Set.from(
                parksNearby
                    .map((e) => _CustomMarker.park(e, () {}))
                    .followedBy([_CustomMarker.destination(destination, () {})]),
              );
            case DestinationsSearchResults(:final destinations):
              markers = Set.from(
                destinations.map((e) =>
                    _CustomMarker.destination(e, () => searchController.searchParksCloseTo(e))),
              );
          }

          return GestureDetector(
            excludeFromSemantics: true,
            behavior: HitTestBehavior.translucent,
            onTapDown: (details) {
              lastTapPosition = RelativeRect.fromLTRB(
                details.globalPosition.dx,
                details.globalPosition.dy + 20,
                details.globalPosition.dx,
                details.globalPosition.dy,
              );
            },
            child: GoogleMap(
              markers: markers,
              onMapCreated: mapController.onMapCreated,
              myLocationEnabled: true,
              mapToolbarEnabled: true,
              padding: EdgeInsets.only(
                top: 156,
                bottom: state is ParksNearbyDestinationResults ? 250 : 0,
              ),
              initialCameraPosition: CameraPosition(
                target: LatLng(mapController.userLatitude, mapController.userLongitude),
                zoom: 10,
              ),
              onLongPress: (location) {
                showMenu(
                  context: context,
                  position: lastTapPosition ?? const RelativeRect.fromLTRB(0, 0, 0, 0),
                  items: [
                    PopupMenuItem(
                      child: const Text("Encontrar estacionamentos próximos"),
                      onTap: () => searchController.searchParksCloseTo(
                        AddressSearchResult(
                            label: "local do mapa", address: "", location: location),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      );
    });
  }
}

extension _CustomMarker on Marker {
  static destination(destination, VoidCallback onTap) {
    return Marker(
      visible: true,
      position: destination.location,
      markerId: MarkerId(destination.label),
      infoWindow: InfoWindow(
        title: destination.label,
        snippet: "Toque para encontrar estacionamentos próximos",
        onTap: onTap, //() => searchController.searchParksCloseTo(e),
      ),
    );
  }

  static park(SearchResult park, void Function() onTap) {
    return Marker(
      onTap: onTap,
      visible: true,
      position: park.location,
      markerId: MarkerId(park.label),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
    );
  }
}
