import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define a model for the appointment data
class Appointment {
  final String patientName;
  final String date;
  final String timeSlot;

  Appointment({required this.patientName, required this.date, required this.timeSlot});
}

// Define a state notifier for managing the list of appointments
class AppointmentsNotifier extends StateNotifier<List<Appointment>> {
  AppointmentsNotifier() : super([]);

  // Method to remove an appointment from the list
  void removeAppointment(Appointment appointment) {
    state = state.where((item) => item != appointment).toList();
  }
}

// Define a provider for the appointments notifier
final appointmentsProvider = StateNotifierProvider<AppointmentsNotifier, List<Appointment>>((ref) {
  return AppointmentsNotifier()
    ..state = [
      Appointment(patientName: 'John Doe', date: '2022-04-04', timeSlot: '11:00 AM - 12:00 PM'),
      Appointment(patientName: 'Jane Smith', date: '2022-04-05', timeSlot: '10:00 AM - 11:00 AM'),
      Appointment(patientName: 'Emily Johnson', date: '2022-04-06', timeSlot: '09:00 AM - 10:00 AM'),
      Appointment(patientName: 'Michael Brown', date: '2022-04-07', timeSlot: '02:00 PM - 03:00 PM'),
      Appointment(patientName: 'Jessica Davis', date: '2022-04-08', timeSlot: '01:00 PM - 02:00 PM'),
      Appointment(patientName: 'Daniel Wilson', date: '2022-04-09', timeSlot: '03:00 PM - 04:00 PM'),
      Appointment(patientName: 'Laura Martinez', date: '2022-04-10', timeSlot: '11:00 AM - 12:00 PM'),
    ];
});

class scheduleDoctor extends ConsumerWidget {
  const scheduleDoctor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the appointments provider to get the list of appointments
    final appointments = ref.watch(appointmentsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Schedule'),
      ),
      body: ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          return Card(
            child: ListTile(
              title: Text(appointment.patientName),
              subtitle: Text('${appointment.date} - ${appointment.timeSlot}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.check_circle, color: Colors.green),
                    onPressed: () {
                      // Handle accept action by removing the appointment
                      ref.read(appointmentsProvider.notifier).removeAppointment(appointment);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.cancel, color: Colors.red),
                    onPressed: () {
                      // Handle deny action by removing the appointment
                      ref.read(appointmentsProvider.notifier).removeAppointment(appointment);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}