import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../reservation/models/reservation.dart';
import '../enums/payment_method.dart';

class ParkSlotsService {
  ParkSlotsService();

  final _supabaseClient = Supabase.instance.client;

  Future<void> reserveSlot(
      int parkId, TimeOfDay beginTime, TimeOfDay endTime, PaymentMethod payment) async {
    final formattedStartTime = "${beginTime.hour}:${beginTime.minute}:00";
    final formattedEndTime = "${endTime.hour}:${endTime.minute}:00";

    await _supabaseClient.rpc('create_reservation', params: {
      'park_id': parkId,
      'start_time': formattedStartTime,
      'end_time': formattedEndTime,
      'payment_type_id': 1
    });
  }

  Future<List<Reservation>> fetchReservations(String userId) async {
    final reservations = await _supabaseClient
        .from('reservation')
        .select('*, park(*)')
        .eq('author_id', userId)
        .order('created_at', ascending: false);

    return reservations.map((e) => Reservation.fromMap(e)).toList();
  }
}
