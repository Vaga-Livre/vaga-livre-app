import 'package:flutter/material.dart';

import '../../../config/extension.dart';

class AppHeaderArea extends StatelessWidget {
  const AppHeaderArea({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      padding: const EdgeInsets.all(16) + const EdgeInsets.only(top: 56),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Horário",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SegmentedButton(
                style: SegmentedButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                ),
                onSelectionChanged: (p0) {},
                segments: const [
                  ButtonSegment(
                    value: TimeOfDay(hour: 10, minute: 0),
                    label: Text(
                      "10:00",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ButtonSegment(
                    value: TimeOfDay(hour: 10, minute: 0),
                    label: Text(
                      "12:00",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                selected: {},
                emptySelectionAllowed: true,
              )
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                "Tipo",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              FilterChip(
                label: const Text(
                  "Carro",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                avatar: const Icon(Icons.directions_car),
                deleteIcon: const Icon(Icons.arrow_drop_down),
                onDeleted: () {},
                onSelected: (value) {},
              )
            ],
          ),
        ],
      ),
    );
  }
}
