import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';

import '../../controllers/map_controller.dart';
import '../../controllers/parks_search_controller.dart';
import 'components/destination_marker.dart';
import 'components/park_details.dart';
import 'components/park_marker.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final myMapController = context.watch<MyMapController>();
    final searchController = context.read<ParksSearchController>();
    return BlocBuilder<ParksSearchController, ParkSearchState>(
      builder: (context, state) {
        final List<AnimatedMarker> markers;

        markerBuilder(DestinationResult result, {required ParkResult? selectedPark}) {
          return destinationToMarker(result, searchController, selectedPark);
        }

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

        final selectedParkDetails =
            selectedPark != null ? ParkDetailsAnimatedMarker(selectedPark) : null;

        markers = List.of(results.map((e) => markerBuilder(e, selectedPark: selectedPark)));

        return FlutterMap(
          mapController: myMapController.animatedMapsController.mapController,
          options: MapOptions(
            initialZoom: 4,
            onTap: (tapPosition, point) => onMapTap(selectedParkDetails, searchController),
            onLongPress: (TapPosition tapPosition, point) =>
                onMapLongPress(context, tapPosition, searchController, point),
            initialCenter: myMapController.userLatitude == 0
                ? const LatLng(-14.235004, -51.92528)
                : LatLng(myMapController.userLatitude, myMapController.userLongitude),
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

  AnimatedMarker destinationToMarker(
      DestinationResult result, ParksSearchController searchController, ParkResult? selectedPark) {
    return AnimatedMarker(
      width: 48,
      height: 64,
      alignment: result is ParkResult ? Alignment.center : Alignment.topCenter,
      point: result.location,
      builder: (context, animation) {
        return result is ParkResult
            ? ParkMarker(
                park: result,
                onPressed: (result) => searchController.selectPark(result),
                selected: selectedPark == result,
              )
            : DestinationMarker(
                destination: result,
                onPressed: searchController.searchParksCloseTo,
              );
      },
    );
  }

  void onMapTap(AnimatedMarker? selectedParkDetails, ParksSearchController searchController) {
    if (selectedParkDetails != null) {
      searchController.selectPark(null);
    }
  }

  void onMapLongPress(BuildContext context, TapPosition tapPosition,
      ParksSearchController searchController, LatLng point) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        tapPosition.global.dx,
        tapPosition.global.dy,
        tapPosition.global.dx,
        tapPosition.global.dy,
      ),
      items: [
        PopupMenuItem(
          child: const Text("Pesquisar estacionamentos aqui"),
          onTap: () {
            searchController.searchParksCloseTo(
              DestinationResult(
                label: "Lugar apontado",
                address: "",
                location: point,
              ),
            );
          },
        ),
      ],
    );
  }
}
