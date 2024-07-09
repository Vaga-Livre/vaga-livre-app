import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../utils/formatters.dart';
import '../home/controllers/parks_search_controller.dart';
import 'components/hour_selection_chip.dart';

class ParkPage extends StatelessWidget {
  const ParkPage({super.key, required this.park});

  final ParkResult park;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final today = DateTime.now();

    final hasSlots = park.slotsCount > 0;

    var sectionTitleStyle = textTheme.titleMedium?.copyWith(color: theme.colorScheme.onSecondaryContainer);

    void _showBottomSheet() {
      Navigator.push(
        context,
        ModalBottomSheetRoute(
          isScrollControlled: true,
          showDragHandle: true,
          builder: (context) => _ReservationBottomSheet(park: park),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(park.label)),
      body: DefaultTextStyle(
        style: TextStyle(color: theme.colorScheme.onSurface),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            SizedBox.fromSize(
              size: const Size.fromHeight(180),
              child: const Placeholder(),
            ),
            Text(park.label, style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "${weekdayFormatter.format(today).toCapitalized()}: "
                  "${currencyFormatter.format(park.price)} por hora",
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                FilledButton(
                  onPressed: _showBottomSheet,
                  child: const Text("Reservar Vaga"),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Descrição", style: sectionTitleStyle),
                Text(park.description, style: textTheme.bodyMedium),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Contatos", style: sectionTitleStyle),
                const Text("Informações de contato indisponíveis"),
              ],
            ),
          ].expand((element) => [element, const SizedBox.square(dimension: 16)]).toList(),
        ),
      ),
    );
  }
}

enum PaymentMethod { creditCard, pix, cash }

class _ReservationBottomSheet extends StatefulWidget {
  const _ReservationBottomSheet({super.key, required this.park});

  final ParkResult park;

  @override
  State<_ReservationBottomSheet> createState() => _ReservationBottomSheetState();
}

class _ReservationBottomSheetState extends State<_ReservationBottomSheet> {
  static final DateFormat shortHourFormat = DateFormat("HH:mm");

  final _formKey = GlobalKey<FormState>();

  TimeOfDay beginTime = const TimeOfDay(hour: 09, minute: 30);
  TimeOfDay endTime = const TimeOfDay(hour: 09, minute: 30);

  PaymentMethod paymentMethod = PaymentMethod.creditCard;

  Duration? duration;
  double? totalPrice;

  bool foo = false;

  void calculatePrice() {
    final now = DateTime.now();
    final begin = DateTime(now.year, now.month, now.day, beginTime.hour, beginTime.minute);
    final end = DateTime(now.year, now.month, now.day, endTime.hour, endTime.minute);

    duration = end.difference(begin);

    totalPrice = (duration!.inMinutes / TimeOfDay.minutesPerHour) * widget.park.price;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      onChanged: () {
        if (_formKey.currentState!.validate()) {
          calculatePrice();
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text("Reservar Vaga", style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500)),
          ),
          _ReservationSection(
            title: const Text("Cheque o horário"),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Previsão de entrada:"),
                    FormField(
                      initialValue: beginTime,
                      validator: (value) {
                        if (value == null) {
                          return "Insira uma hora";
                        }

                        if (value == endTime) {
                          return "Insira uma hora diferente";
                        }

                        return null;
                      },
                      builder: (state) {
                        return HourSelectionChip(
                          time: state.value,
                          error: state.errorText,
                          onSelected: (value) {
                            log(value.toString());

                            if (value == null) {
                              return;
                            }

                            setState(() {
                              beginTime = value;
                              state.didChange(beginTime);
                            });
                          },
                        );
                      },
                    ),
                  ],
                ),
                Divider(height: 4, color: theme.colorScheme.onInverseSurface),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Previsão de saída:"),
                    FormField(
                      initialValue: beginTime,
                      validator: (value) {
                        if (value == null) {
                          return "Insira uma hora";
                        }

                        if (value == beginTime) {
                          return "Insira uma hora diferente";
                        }

                        if (value.hour < beginTime.hour ||
                            (value.hour == beginTime.hour && value.minute < beginTime.minute)) {
                          return "A saída não pode ser antes da entrada";
                        }

                        return null;
                      },
                      builder: (state) {
                        return HourSelectionChip(
                          time: state.value,
                          error: state.errorText,
                          onSelected: (value) {
                            log(value.toString());

                            if (value == null) {
                              return;
                            }

                            setState(() {
                              endTime = value;
                              state.didChange(endTime);
                            });
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Método de pagamento
          if (!foo)
            _ReservationSection(
              title: const Text("Método de pagamento"),
              child: ListTileTheme(
                data: const ListTileThemeData(visualDensity: VisualDensity(vertical: -4, horizontal: -4)),
                child: FormField<PaymentMethod>(builder: (state) {
                  paymentMethodChanged(PaymentMethod? value) {
                    setState(() {
                      state.didChange(value);
                      paymentMethod = value ?? PaymentMethod.values.first;
                    });
                  }

                  return Column(
                    children: [
                      RadioListTile.adaptive(
                        value: PaymentMethod.pix,
                        groupValue: paymentMethod,
                        onChanged: paymentMethodChanged,
                        title: const Row(
                          children: [
                            Icon(Icons.pix),
                            SizedBox.square(dimension: 8),
                            Text("PIX"),
                          ],
                        ),
                      ),
                      const Divider(height: 0, indent: 16),
                      RadioListTile.adaptive(
                        value: PaymentMethod.creditCard,
                        groupValue: paymentMethod,
                        onChanged: paymentMethodChanged,
                        title: const Row(
                          children: [
                            Icon(Icons.credit_card),
                            SizedBox.square(dimension: 8),
                            Text("Cartão de crédito"),
                          ],
                        ),
                      ),
                      const Divider(height: 0, indent: 16),
                      RadioListTile.adaptive(
                        value: PaymentMethod.cash,
                        groupValue: paymentMethod,
                        onChanged: paymentMethodChanged,
                        title: const Row(
                          children: [
                            Icon(Icons.money),
                            SizedBox.square(dimension: 8),
                            Text("Dinheiro em espécie"),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          _ReservationSection(
            title: const Text("Resumo da reserva"),
            child: DefaultTextStyle(
              style: textTheme.bodyMedium!.copyWith(height: 1.75),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Duração:"),
                      const SizedBox.square(dimension: 8),
                      Text(
                        shortHourFormat.format(
                          DateTime.fromMillisecondsSinceEpoch(
                            duration?.inMilliseconds ?? 0,
                            isUtc: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Valor por hora:"),
                      const SizedBox.square(dimension: 8),
                      Text(currencyFormatter.format(widget.park.price)),
                    ],
                  ),
                  const Divider(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total:",
                        style: textTheme.titleMedium!.copyWith(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox.square(dimension: 8),
                      Text(
                        currencyFormatter.format(totalPrice ?? 0),
                        style: textTheme.titleMedium!.copyWith(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FilledButton(
                onPressed: totalPrice != null ? () {} : null,
                child: const Text("Reservar Vaga"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReservationSection extends StatelessWidget {
  const _ReservationSection({super.key, required this.title, required this.child});

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
            style: textTheme.bodyLarge!.copyWith(color: theme.colorScheme.onSurfaceVariant, height: 1.75),
            child: title,
          ),
          const SizedBox(height: 8),
          DefaultTextStyle(style: textTheme.bodyMedium!.copyWith(color: theme.colorScheme.onSurface), child: child),
        ],
      ),
    );
  }
}
