import 'package:supabase_flutter/supabase_flutter.dart';

class ParkSlotsService {
  ParkSlotsService();
  
  final _supabaseClient = Supabase.instance.client;

  Future<void> reserveSlot(String parkId) async {
    final response = await _supabaseClient.from('park_slots').insert(
      {'park_id': parkId, 'reserved': true},
    );
  }
}
