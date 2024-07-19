import 'package:flutter/material.dart';

class ReservationSection extends StatelessWidget {
  const ReservationSection({required this.title, required this.child});

  final Widget title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      decoration: ShapeDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultTextStyle(
            style: textTheme.bodyLarge!.copyWith(
                color: theme.colorScheme.onSurfaceVariant, height: 1.75),
            child: title,
          ),
          const SizedBox(height: 8),
          DefaultTextStyle(
              style: textTheme.bodyMedium!
                  .copyWith(color: theme.colorScheme.onSurface),
              child: child),
        ],
      ),
    );
  }
}
