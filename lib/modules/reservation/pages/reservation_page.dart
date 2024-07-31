import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../utils/formatters.dart';
import '../../park/services/park_slots_service.dart';
import '../controllers/reservations_list_controller.dart';
import '../models/reservation.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  static final dateFormatter = DateFormat.yMd();
  static final shortHourFormat = DateFormat.Hm();

  @override
  Widget build(BuildContext context) {
    const edgeInsets = EdgeInsets.symmetric(horizontal: 16);

    return ChangeNotifierProvider(
      create: (context) => ReservationsListController(
        ParkSlotsService(),
      )..fetchReservations(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Suas reservas'),
          actions: [
            Builder(builder: (context) {
              return IconButton(
                onPressed: () async {
                  final controller = context.read<ReservationsListController>();
                  await controller.fetchReservations();
                },
                icon: const Icon(Icons.refresh),
              );
            })
          ],
        ),
        body: Builder(builder: (context) {
          final controller = context.watch<ReservationsListController>();

          final reservations = controller.reservations;
          final error = controller.error;
          final isLoading = controller.isLoading;

          if (error != null && error.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(error),
              ));
            });
          }

          if (!isLoading && reservations.isEmpty) {
            return const Center(
              child: Text("Nenhuma reserva"),
            );
          }

          return RefreshIndicator(
            onRefresh: () async => context.read<ReservationsListController>().fetchReservations(),
            child: isLoading
                ? const Center(
                    heightFactor: 1,
                    child: RefreshProgressIndicator(),
                  )
                : ListView.separated(
                    separatorBuilder: (context, index) => const Divider(height: 0),
                    itemCount: reservations.length,
                    itemBuilder: (context, index) {
                      final reservation = reservations[index];

                      final status = ReservationStatus.fromInt(reservation.status);
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
                                      Text("Data"),
                                      Text(
                                        style: Theme.of(context).textTheme.bodyLarge,
                                        dateFormatter.format(reservation.date),
                                      ),
                                    ],
                                  ),
                                  Column(children: [
                                    Text("Valor"),
                                    Text(
                                      style: Theme.of(context).textTheme.bodyLarge,
                                      currencyFormatter.format(reservation.hourlyRate),
                                    )
                                  ]),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("Duração"),
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
                    },
                  ),
          );
        }),
      ),
    );
  }
}

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

extension StatusWidget on ReservationStatus {
  IconData get icon {
    switch (this) {
      case ReservationStatus.waiting:
        return Icons.access_time;
      case ReservationStatus.declined:
        return Icons.close;
      case ReservationStatus.accepted:
        return Icons.check;
    }
  }

  String get text {
    switch (this) {
      case ReservationStatus.waiting:
        return 'Aguardando\nconfirmação';
      case ReservationStatus.declined:
        return 'Recusada';
      case ReservationStatus.accepted:
        return 'Confirmada';
    }
  }

  Color get color {
    switch (this) {
      case ReservationStatus.waiting:
        return Colors.orange;
      case ReservationStatus.declined:
        return Colors.red;
      case ReservationStatus.accepted:
        return Colors.green;
    }
  }
}
