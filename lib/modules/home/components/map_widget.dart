import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../parks/controllers/parks_search_controller.dart';
import '../controller/map_controller.dart';

class MapWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final mapController = context.watch<MapController>();
      final searchController = context.watch<ParksSearchController>();
      print(searchController.results);
      return GoogleMap(
        // onTap: print,
        // onLongPress: print,
        // onCameraMove: print,
        onMapCreated: mapController.onMapCreated,
        compassEnabled: true,
        myLocationEnabled: true,
        mapToolbarEnabled: true,
        zoomGesturesEnabled: true,
        padding: const EdgeInsets.only(top: 156),
        // TODO: Enhance markers: Implement tap callbacks, label, content, color, number of free slots
        markers: searchController.results
                ?.map((e) => Marker(
                      markerId: MarkerId(e.label),
                      // onTap: () => searchController.selectTerm(e),
                      visible: true,
                      position: e.location,
                    ))
                .toSet() ??
            {},
        initialCameraPosition: CameraPosition(
          target: LatLng(mapController.userLatitude, mapController.userLongitude),
          zoom: 18,
        ),
      );
    });
  }
}
