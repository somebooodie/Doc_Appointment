// appointment_info.dart

import 'package:flutter/material.dart';

class AppointmentInfo {
  final String doctorName;
  final TimeOfDay appointmentTime;
  final DateTime date;

  AppointmentInfo({
    required this.doctorName,
    required this.appointmentTime,
    required this.date,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppointmentInfo &&
        other.doctorName == doctorName &&
        other.appointmentTime == appointmentTime &&
        other.date == date;
  }

  @override
  int get hashCode {
    return doctorName.hashCode ^ appointmentTime.hashCode ^ date.hashCode;
  }
}
