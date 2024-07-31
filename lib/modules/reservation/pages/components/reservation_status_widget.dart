import 'package:flutter/material.dart';

import '../../models/reservation.dart';
import '../reservation_page.dart';

class ReservationStatusWidget extends StatelessWidget {
  const ReservationStatusWidget({
    super.key,
    required this.status,
  });

  final ReservationStatus status;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: TextStyle(color: status.color),
      child: IconTheme.merge(
        data: IconThemeData(color: status.color),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          // TODO: change to payment status
          children: [Icon(status.icon), const SizedBox.square(dimension: 4), Text(status.text)],
        ),
      ),
    );
  }
}
