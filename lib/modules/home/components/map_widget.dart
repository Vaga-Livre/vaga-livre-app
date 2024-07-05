import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../controllers/map_controller.dart';
import '../controllers/parks_search_controller.dart';

class MapWidget extends StatelessWidget {
  RelativeRect? lastTapPosition;

  MapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final mapController = context.watch<MyMapController>();
    final searchController = context.read<ParksSearchController>();
    return BlocBuilder<ParksSearchController, ParkSearchState>(
      builder: (context, state) {
        final List<Marker> markers;

        markerBuilder(DestinationResult result) => Marker(
              point: result.location,
              child: result is ParkResult
                  ? ParkMarker(
                      park: result, onPressed: (result) => context.go("/park", extra: result))
                  : DestinationMarker(
                      destination: result, onPressed: searchController.searchParksCloseTo),
            );

        switch (state) {
          case LoadingResults():
            markers = [];
          case MapViewParksResults(:final parksNearby):
            markers = List.of([...parksNearby].map(markerBuilder));
          case ParksNearbyDestinationResults(:final parksNearby, :final destination):
            markers = List.of([...parksNearby, destination].map(markerBuilder));
          case DestinationsSearchResults(:final destinations):
            markers = List.of([...destinations].map(markerBuilder));
        }

        final theme = Theme.of(context);

        return FlutterMap(
          mapController: mapController.mapsController,
          options: MapOptions(
            initialCenter: LatLng(mapController.userLatitude, mapController.userLongitude),
          ),
          children: [
            TileLayer(
              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              userAgentPackageName: 'br.com.vagalivre.app',
            ),
            CurrentLocationLayer(
              alignPositionOnUpdate: AlignOnUpdate.once,
              indicators: const LocationMarkerIndicators(
                permissionDenied: Icon(Icons.no_accounts),
                permissionRequesting: Icon(Icons.refresh),
                serviceDisabled: Icon(Icons.disabled_by_default),
              ),
            ),
            MarkerLayer(
              markers: markers,
              rotate: true,
              alignment: Alignment.center,
            ),
            const Align(
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [Text("data")],
              ),
            ),
          ],
        );
      },
    );
  }
}

class DestinationMarker extends StatelessWidget {
  const DestinationMarker({
    required this.destination,
    required this.onPressed,
    super.key,
  });

  final DestinationResult destination;
  final void Function(DestinationResult) onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return IconButton(
      iconSize: 48,
      splashRadius: 56,
      color: theme.colorScheme.error,
      visualDensity: VisualDensity.standard,
      isSelected: true,
      alignment: Alignment.topCenter,
      onPressed: () => onPressed(destination),
      icon: const Icon(Icons.location_on_rounded),
      selectedIcon: const Icon(Icons.add_location_alt_rounded),
    );
  }
}

class ParkMarker extends StatelessWidget {
  const ParkMarker({
    required this.park,
    required this.onPressed,
    super.key,
  });

  final ParkResult park;
  final void Function(ParkResult) onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return IconButton(
      icon: Icon(Icons.location_on_rounded, size: 48, color: theme.colorScheme.primary),
      onPressed: () => onPressed(park),
    );
  }
}

// extension _CustomMarker on Marker {
//   static destination(destination, VoidCallback onTap) {
//     return Marker(
//       visible: true,
//       position: destination.location,
//       markerId: MarkerId(destination.label),
//       infoWindow: InfoWindow(
//         title: destination.label,
//         snippet: "Toque para encontrar estacionamentos próximos",
//         onTap: onTap, //() => searchController.searchParksCloseTo(e),
//       ),
//     );
//   }

//   static park(ParkResult park, void Function() onTap) {
//     return Marker(
//       onTap: onTap,
//       visible: true,
//       position: park.location,
//       markerId: MarkerId(park.label),
//       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
//     );
//   }
