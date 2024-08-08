part of 'reservation_cubit.dart';

abstract class ReservationState {}

class InitialReservationState extends ReservationState {}

class ReservationLoadingState extends ReservationState {}

class ReservationConfirmedState extends ReservationState {}

class ReservationFailedState extends ReservationState {
  final String message;

  ReservationFailedState({required this.message});
}
