import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../config/extension.dart';
import '../../park/models/park.dart';

enum ReservationStatus {
  waiting,
  declined,
  accepted;

  static ReservationStatus fromInt(int value) {
    return ReservationStatus.values[value - 1];
  }
}

class Reservation {
  final int id;
  final Park park;
  final TimeOfDay startTime;
  final double hourlyRate;
  final String authorId;
  final int status;
  final TimeOfDay endTime;
  final DateTime date;
  final DateTime createdAt;

  Duration get duration {
    final now = DateTime.now();
    final begin = DateTime(now.year, now.month, now.day, startTime.hour, startTime.minute);
    final end = DateTime(now.year, now.month, now.day, endTime.hour, endTime.minute);

    return end.difference(begin);
  }

  double get totalValue => (duration.inMinutes / TimeOfDay.minutesPerHour) * hourlyRate;

  Reservation({
    required this.id,
    required this.park,
    required this.startTime,
    required this.hourlyRate,
    required this.authorId,
    required this.status,
    required this.endTime,
    required this.date,
    required this.createdAt,
  });

  Reservation copyWith({
    int? id,
    Park? park,
    TimeOfDay? startTime,
    double? hourlyRate,
    String? authorId,
    int? status,
    TimeOfDay? endTime,
    DateTime? date,
    DateTime? createdAt,
  }) {
    return Reservation(
      id: id ?? this.id,
      park: park ?? this.park,
      startTime: startTime ?? this.startTime,
      hourlyRate: hourlyRate ?? this.hourlyRate,
      authorId: authorId ?? this.authorId,
      status: status ?? this.status,
      endTime: endTime ?? this.endTime,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'park': park,
      'start_time': startTime.toISOString(),
      'hourly_rate': hourlyRate,
      'author_id': authorId,
      'status': status,
      'end_time': endTime.toISOString(),
      'date': date.millisecondsSinceEpoch,
      'created_at': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Reservation.fromMap(Map<String, dynamic> map) {
    return Reservation(
      id: map['id'] as int,
      park: Park.fromMap(map['park'] as Map<String, dynamic>),
      startTime: TimeOfDayMap.parseIso(map['start_time']),
      hourlyRate: (map['hourly_rate'] as num).toDouble(),
      authorId: map['author_id'] as String,
      status: map['status'] as int,
      endTime: TimeOfDayMap.parseIso(map['end_time']),
      date: DateTime.parse(map['date']),
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Reservation(id: $id, startTime: $startTime, hourlyRate: $hourlyRate, authorId: $authorId, status: $status, endTime: $endTime, date: $date, createdAt: $createdAt, , park: $park)';
  }
}
