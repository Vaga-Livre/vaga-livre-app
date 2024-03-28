import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vagalivre/modules/home/controller/map_controller.dart';

class MapWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MapController>(
      create: (context) => MapController(),
      child: Builder(builder: (context) {
        final local = context.watch<MapController>();

        return GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(local.lat, local.long),
            zoom: 18,
          ),
          zoomControlsEnabled: true,
          zoomGesturesEnabled: true,
          mapType: MapType.normal,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          onMapCreated: local.onMapCreated,
        );
      }),
    );
  }
}
