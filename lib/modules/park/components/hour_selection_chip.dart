import 'package:flutter/material.dart';

class HourSelectionChip extends StatelessWidget {
  const HourSelectionChip({
    super.key,
    required this.time,
    required this.onSelected,
    this.error,
  });

  final TimeOfDay? time;
  final String? error;
  final void Function(TimeOfDay?)? onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InputChip(
          onPressed: () async {
            final value = await showTimePicker(
              context: context,
              initialTime: time ?? const TimeOfDay(hour: 9, minute: 0),
              errorInvalidText: error,
            );

            onSelected?.call(value);
          },
          avatar: Icon(
            Icons.access_time,
            color: theme.colorScheme.primary,
          ),
          visualDensity: VisualDensity.compact,
          label: Text(time?.format(context) ?? "--:--"),
        ),
        if (error != null)
          Text(
            error!,
            style: textTheme.bodySmall!.copyWith(color: theme.colorScheme.error),
          ),
      ],
    );
  }
}
