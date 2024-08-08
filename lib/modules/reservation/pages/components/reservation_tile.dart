import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../utils/formatters.dart';
import '../../models/reservation.dart';
import 'reservation_status_widget.dart';

class ReservationTile extends StatelessWidget {
  const ReservationTile({
    super.key,
    required this.reservation,
    required this.edgeInsets,
    required this.status,
    required this.dateFormatter,
    required this.shortHourFormat,
  });

  final Reservation reservation;
  final EdgeInsets edgeInsets;
  final ReservationStatus status;
  final DateFormat dateFormatter;
  final DateFormat shortHourFormat;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.go("/reservation/${reservation.id}"),
      child: Column(
        children: [
          ListTile(
            isThreeLine: true,
            leading: const Icon(Icons.directions_car),
            contentPadding: edgeInsets,
            title: Text(reservation.park.name),
            subtitle: Text(reservation.park.address),
            trailing: ReservationStatusWidget(status: status),
          ),
          Padding(
            padding: edgeInsets + const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Data"),
                    Text(
                      style: Theme.of(context).textTheme.bodyLarge,
                      dateFormatter.format(reservation.date),
                    ),
                  ],
                ),
                Column(children: [
                  const Text("Valor"),
                  Text(
                    style: Theme.of(context).textTheme.bodyLarge,
                    currencyFormatter.format(reservation.hourlyRate),
                  )
                ]),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text("Duração"),
                    Text(
                      style: Theme.of(context).textTheme.bodyLarge,
                      shortHourFormat.format(
                        DateTime.fromMillisecondsSinceEpoch(
                          reservation.duration.inMilliseconds,
                          isUtc: true,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
