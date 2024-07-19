import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:vagalivre/modules/park/cubit/reservation_cubit.dart';
import 'package:vagalivre/utils/toast_message.dart';

import '../../../utils/formatters.dart';
import 'hour_selection_chip.dart';
import '../cubit/reservation_state';
import '../enums/payment_method.dart';
import '../../home/models/park_result.dart';
import '../services/park_slots_service.dart';
import 'reservation_section.dart';

class ReservationBottomSheet extends StatefulWidget {
  const ReservationBottomSheet({super.key, required this.park});

  final ParkResult park;

  @override
  State<ReservationBottomSheet> createState() => _ReservationBottomSheetState();
}

class _ReservationBottomSheetState extends State<ReservationBottomSheet> {
  static final DateFormat shortHourFormat = DateFormat("HH:mm");

  final _formKey = GlobalKey<FormState>();

  TimeOfDay beginTime = const TimeOfDay(hour: 09, minute: 30);
  TimeOfDay endTime = const TimeOfDay(hour: 09, minute: 30);

  PaymentMethod paymentMethod = PaymentMethod.creditCard;

  Duration? duration;
  double? totalPrice;

  bool foo = false;

  late ToastMessage toastMessage;

  @override
  void initState() {
    super.initState();
    toastMessage = ToastMessage(context);
  }

  final ParkSlotsService parkSlotsService = ParkSlotsService();

  void calculatePrice() {
    final now = DateTime.now();
    final begin = DateTime(
        now.year, now.month, now.day, beginTime.hour, beginTime.minute);
    final end =
        DateTime(now.year, now.month, now.day, endTime.hour, endTime.minute);

    duration = end.difference(begin);

    totalPrice =
        (duration!.inMinutes / TimeOfDay.minutesPerHour) * widget.park.price;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return BlocProvider(
      create: (context) => ReservationCubit(
          ParkSlotsService()), // Supondo que você injete o serviço aqui
      child: BlocListener<ReservationCubit, ReservationState>(
        listener: (context, state) {
          if (state is ReservationLoadingState) {
            // Exibir um indicador de carregamento
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          } else if (state is ReservationConfirmedState) {
            Navigator.of(context)
              ..pop()
              ..pop()
              ..pop();
            toastMessage.showSucess("Reserva realizada com sucesso!");
          } else if (state is ReservationFailedState) {
            Navigator.of(context)
              ..pop()
              ..pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Builder(
          builder: (context) {
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
                    child: Text("Reservar Vaga",
                        style: textTheme.titleLarge
                            ?.copyWith(fontWeight: FontWeight.w500)),
                  ),
                  ReservationSection(
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
                        Divider(
                            height: 4,
                            color: theme.colorScheme.onInverseSurface),
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
                                    (value.hour == beginTime.hour &&
                                        value.minute < beginTime.minute)) {
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
                    ReservationSection(
                      title: const Text("Método de pagamento"),
                      child: ListTileTheme(
                        data: const ListTileThemeData(
                            visualDensity:
                                VisualDensity(vertical: -4, horizontal: -4)),
                        child: FormField<PaymentMethod>(builder: (state) {
                          paymentMethodChanged(PaymentMethod? value) {
                            setState(() {
                              state.didChange(value);
                              paymentMethod =
                                  value ?? PaymentMethod.values.first;
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
                  ReservationSection(
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
                                style: textTheme.titleMedium!.copyWith(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox.square(dimension: 8),
                              Text(
                                currencyFormatter.format(totalPrice ?? 0),
                                style: textTheme.titleMedium!.copyWith(
                                    fontSize: 18, fontWeight: FontWeight.w500),
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
                        onPressed: totalPrice != null
                            ? () {
                                context.read<ReservationCubit>().reserveSlot(
                                    widget.park.id,
                                    beginTime,
                                    endTime,
                                    paymentMethod);
                              }
                            : null,
                        child: const Text("Reservar Vaga"),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
