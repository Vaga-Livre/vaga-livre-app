import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../utils/widgets_utils.dart';
import '../../park/services/park_slots_service.dart';
import '../controllers/reservations_list_controller.dart';
import '../models/reservation.dart';
import 'components/reservation_tile.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  static const maxWidth = 640.0;

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  final dateFormatter = DateFormat.yMd("pt-br");
  final shortHourFormat = DateFormat.Hm();

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
                    padding: EdgeInsetsExtension.maxWidth(
                        width: MediaQuery.sizeOf(context).width,
                        maxWidth: ReservationPage.maxWidth),
                    separatorBuilder: (context, index) => const Divider(height: 0),
                    itemCount: reservations.length,
                    itemBuilder: (context, index) {
                      final reservation = reservations[index];

                      final status = ReservationStatus.fromInt(reservation.status);
                      return ReservationTile(
                        reservation: reservation,
                        edgeInsets: edgeInsets,
                        status: status,
                        dateFormatter: dateFormatter,
                        shortHourFormat: shortHourFormat,
                      );
                    },
                  ),
          );
        }),
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
