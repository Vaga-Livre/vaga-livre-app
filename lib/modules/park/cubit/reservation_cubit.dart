import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
    } on PostgrestException catch(e) {
      emit(ReservationFailedState(message: "Erro no banco de dados: ${e.message}"));
    } catch (e) {
      emit(ReservationFailedState(message: "Ocorreu um erro inesperado! Por favor, entre em contato com o time de suporte."));
    }
  }
}
