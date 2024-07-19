import 'destination_result.dart';

class ParkResult extends DestinationResult {
  final int id;
  final String description;
  final int slotsCount;
  final double price;

  const ParkResult({
    required this.id,
    required super.label,
    required super.address,
    required super.location,
    required this.description,
    required this.slotsCount,
    required this.price,
  });
}
