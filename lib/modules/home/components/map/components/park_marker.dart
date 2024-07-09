import 'package:flutter/material.dart';

import '../../../controllers/parks_search_controller.dart';

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
      color: selected ? theme.colorScheme.onPrimary : theme.colorScheme.onPrimary.withOpacity(0.87),
      icon: Icon(
        Icons.directions_car_outlined,
        size: 20,
      ),
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
