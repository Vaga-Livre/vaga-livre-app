import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:vagalivre/modules/home/components/map/components/park_details.dart';

import '../controllers/map_controller.dart';
import '../controllers/parks_search_controller.dart';

class MapWidget extends StatelessWidget {
  RelativeRect? lastTapPosition;

  MapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final myMapController = context.watch<MyMapController>();
    final searchController = context.read<ParksSearchController>();
    return BlocBuilder<ParksSearchController, ParkSearchState>(
      builder: (context, state) {
        final List<AnimatedMarker> markers;

        markerBuilder(DestinationResult result, {required ParkResult? selectedPark}) =>
            AnimatedMarker(
              width: 48,
              height: 64,
              alignment: Alignment.topCenter,
              point: result.location,
              builder: (context, animation) {
                return result is ParkResult
                    ? ParkMarker(
                        park: result,
                        onPressed: (result) => context.go("/park", extra: result),
                        selected: selectedPark == result,
                      )
                    : DestinationMarker(
                        destination: result, onPressed: searchController.searchParksCloseTo);
              },
            );

        final List<DestinationResult> results;
        switch (state) {
          case LoadingResults():
            results = [];
            break;
          case MapViewParksResults(:final parksNearby):
            results = [...parksNearby];
            break;
          case ParksNearbyDestinationResults(:final parksNearby, :final destination):
            results = [...parksNearby, destination];
            break;
          case DestinationsSearchResults(:final destinations):
            results = [...destinations];
            break;
        }

        final selectedPark = state is ParksNearbyDestinationResults ? state.selectedPark : null;
        markers = List.of(results.map(
          (e) => markerBuilder(
            e,
            selectedPark: selectedPark,
          ),
        ));
        final selectedParkDetails = selectedPark != null
            ? AnimatedMarker(
                point: selectedPark.location,
                width: 250,
                height: 152,
                alignment: Alignment.topCenter,
                builder: (context, animation) {
                  return ParkDetails(park: selectedPark);
                })
            : null;

        final theme = Theme.of(context);

        return FlutterMap(
          mapController: myMapController.animatedMapsController.mapController,
          options: MapOptions(
              initialCenter: LatLng(myMapController.userLatitude, myMapController.userLongitude)),
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
            AnimatedMarkerLayer(
              markers: [...markers, if (selectedParkDetails != null) selectedParkDetails],
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
    required this.selected,
    super.key,
  });

  final ParkResult park;
  final bool selected;
  final void Function(ParkResult) onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return IconButton.filled(
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      onPressed: () => onPressed(park),
      color: selected ? theme.colorScheme.tertiary : theme.colorScheme.onPrimary,
      icon: Icon(Icons.flag_circle_rounded),
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
