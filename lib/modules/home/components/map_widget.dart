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
          onTap: print,
          onLongPress: print,
          onCameraMove: print,
          onMapCreated: local.onMapCreated,
          compassEnabled: true,
          myLocationEnabled: true,
          mapToolbarEnabled: true,
          zoomGesturesEnabled: true,
          padding: const EdgeInsets.only(top: 156),
          initialCameraPosition: CameraPosition(
            target: LatLng(local.userLatitude, local.userLongitude),
            zoom: 18,
          ),
        );
      }),
    );
  }
}
