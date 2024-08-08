import 'package:latlong2/latlong.dart';

class DestinationResult {
  final String label;
  final String address;
  final LatLng location;

  const DestinationResult(
      {required this.label, required this.address, required this.location});
}
