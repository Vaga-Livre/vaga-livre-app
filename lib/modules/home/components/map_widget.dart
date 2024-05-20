import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../parks/controllers/parks_search_controller.dart';
import '../controller/map_controller.dart';

class MapWidget extends StatelessWidget {
  RelativeRect? lastTapPosition;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final mapController = context.watch<MapController>();
      final searchController = context.watch<ParksSearchController>();
      print(searchController.resultsParks);
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
          onMapCreated: mapController.onMapCreated,
          onLongPress: (location) {
            showMenu(
              context: context,
              position: lastTapPosition ?? const RelativeRect.fromLTRB(0, 0, 0, 0),
              items: [
                const PopupMenuItem(child: Text("Encontrar estacionamentos próximos")),
              ],
            );
          },
          compassEnabled: true,
          myLocationEnabled: true,
          mapToolbarEnabled: true,
          zoomGesturesEnabled: true,
          padding: EdgeInsets.only(
              top: 156, bottom: searchController.resultsParks?.isEmpty == true ? 0 : 250),
          // TODO: Enhance markers: Implement tap callbacks, label, content, color, number of free slots
          markers: {
            ...searchController.resultsParks
                    ?.map(
                      (e) => Marker(
                        markerId: MarkerId(e.label),
                        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
                        // onTap: () => searchController.selectTerm(e),
                        visible: true,
                        position: e.location,
                      ),
                    )
                    .toSet() ??
                {},
            ...searchController.addressesResults
                .map(
                  (e) => Marker(
                    markerId: MarkerId(e.label),
                    visible: true,
                    position: e.location,
                    infoWindow: InfoWindow(
                      title: e.label,
                      snippet: "Toque para encontrar estacionamentos próximos",
                      onTap: () => searchController.searchParksCloseTo(e),
                    ),
                  ),
                )
                .toSet()
          },
          initialCameraPosition: CameraPosition(
            target: LatLng(mapController.userLatitude, mapController.userLongitude),
            zoom: 10,
          ),
        ),
      );
    });
  }
}
