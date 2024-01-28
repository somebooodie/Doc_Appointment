// appointment_details_page.dart

import 'package:doc_appointment/app/modules/views/appointments_info.dart';
import 'package:flutter/material.dart';

class AppointmentDetailsPage extends StatelessWidget {
  final AppointmentInfo appointmentInfo;

  AppointmentDetailsPage({required this.appointmentInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Doctor: ${appointmentInfo.doctorName}',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Appointment Time: ${appointmentInfo.appointmentTime.format(context)}',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
