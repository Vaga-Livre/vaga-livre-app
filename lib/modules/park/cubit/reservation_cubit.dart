import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:vagalivre/modules/park/services/park_slots_service.dart';

import '../enums/payment_method.dart';

part 'reservation_state.dart';

class ReservationCubit extends Cubit<ReservationState> {
  final ParkSlotsService _parkSlotsService;

  ReservationCubit(this._parkSlotsService) : super(InitialReservationState());

  void reserveSlot(
    int parkId,
    TimeOfDay beginTime,
    TimeOfDay endTime,
    PaymentMethod paymentMethod,
  ) async {
    emit(ReservationLoadingState());
    try {
      await _parkSlotsService.reserveSlot(parkId, beginTime, endTime, paymentMethod);
      emit(ReservationConfirmedState());
    } catch (e) {
      emit(ReservationFailedState(message: e.toString()));
    }
  }
}
