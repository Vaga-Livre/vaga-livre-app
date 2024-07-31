import 'dart:convert';

class Park {
  final int id;
  final String name;
  final String description;
  final String address;
  final double latitude;
  final double longitude;
  final double hourlyRate;

  const Park({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.hourlyRate,
  });

  Park copyWith({
    int? id,
    String? name,
    String? description,
    String? address,
    double? latitude,
    double? longitude,
    double? hourlyRate,
  }) {
    return Park(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      hourlyRate: hourlyRate ?? this.hourlyRate,
    );
  }

  factory Park.fromMap(Map<String, dynamic> map) {
    return Park(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      address: map['address_line'] as String,
      latitude: double.parse(map['latitude']),
      longitude: double.parse(map['longitude']),
      hourlyRate: (map['hourly_rate'] as num).toDouble(),
    );
  }

  @override
  String toString() {
    return 'Park(id: $id, name: $name, description: $description, address: $address, latitude: $latitude, longitude: $longitude, hourlyRate: $hourlyRate)';
  }
}
