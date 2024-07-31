import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../park/services/park_slots_service.dart';
import '../models/reservation.dart';

class ReservationsListController extends ChangeNotifier {
  ReservationsListController(this._parkSlotsService);

  final ParkSlotsService _parkSlotsService;
  final User user = Supabase.instance.client.auth.currentUser!;

  List<Reservation> reservations = [];
  bool isLoading = true;
  String? error;

  Future<void> fetchReservations() async {
    _notifyLoading(true);

    try {
      reservations = await _parkSlotsService.fetchReservations(user.id);
    } catch (e, st) {
      log("Erro on fetchReservations:", error: e, stackTrace: st);
      _notifyError(e.toString());
    } finally {
      _notifyLoading(false);
    }
  }

  _notifyLoading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  _notifyError(String? error) {
    this.error = error;
    notifyListeners();
  }
}
