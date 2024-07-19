import 'package:flutter/material.dart';

import '../../../models/destination_result.dart';

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
      color: theme.colorScheme.error,
      padding: EdgeInsets.zero,
      isSelected: true,
      alignment: Alignment.topCenter,
      onPressed: () => onPressed(destination),
      icon: const Icon(Icons.location_on_rounded),
      selectedIcon: const Icon(Icons.add_location_alt_rounded),
    );
  }
}
