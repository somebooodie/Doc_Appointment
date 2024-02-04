import 'package:doc_appointment/app/config/routes/named_routes.dart';
import 'package:doc_appointment/app/config/theme/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Availability extends StatefulWidget {
  @override
  _AvailabilityState createState() => _AvailabilityState();
}

class _AvailabilityState extends State<Availability> {
  DateTime? selectedDate;
  String? selectedTimeSlot;

  void _toggleDate(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  void _toggleTimeSlot(String timeSlot) {
    setState(() {
      selectedTimeSlot = timeSlot;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Availability'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Date:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _buildDateList(),
            SizedBox(height: 16),
            Text(
              'Select Time Slot:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _buildTimeSlotList(),
            ElevatedButton(
              onPressed: () {
                // GoRouter.of(context).goNamed(MyNamedRoutes.availability);
              },
              style: ElevatedButton.styleFrom(
                primary: MyColors.primary_500, // Background color of the button
                onPrimary: MyColors.white, // Text color of the button
              ),
              child: Text("Book"),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDateList() {
    return Column(
      children: [
        for (DateTime date in _getWeekdays())
          RadioListTile<DateTime>(
            title: Text(
              '${date.day}/${date.month}/${date.year}',
              style: TextStyle(fontSize: 16),
            ),
            value: date,
            groupValue: selectedDate,
            onChanged: (DateTime? value) => _toggleDate(value!),
          ),
      ],
    );
  }

  Widget _buildTimeSlotList() {
    // For simplicity, using static time slots. You can fetch dynamic time slots from your backend.
    List<String> timeSlots = [
      '11:00 AM - 12:00 PM',
      '12:00 PM - 1:00 PM',
      '1:00 PM - 2:00 PM'
    ];

    return Column(
      children: [
        for (String timeSlot in timeSlots)
          RadioListTile<String>(
            title: Text(
              timeSlot,
              style: TextStyle(fontSize: 16),
            ),
            value: timeSlot,
            groupValue: selectedTimeSlot,
            onChanged: (String? value) => _toggleTimeSlot(value!),
          ),
      ],
    );
  }

  List<DateTime> _getWeekdays() {
    DateTime now = DateTime.now();
    List<DateTime> weekdays = [];
    for (int i = 0; i < 3; i++) {
      DateTime date = DateTime(now.year, now.month + 1, now.day + i);
      if (date.weekday >= 1 && date.weekday <= 5) {
        weekdays.add(date);
      }
    }
    return weekdays;
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: Availability(),
//   ));
// }
