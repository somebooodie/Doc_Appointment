import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_appointment/app/modules/views/calendar/event.dart';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class PatientCalendarScreen extends StatefulWidget {
  const PatientCalendarScreen({super.key});

  @override
  _PatientCalendarPageState createState() => _PatientCalendarPageState();
}

class _PatientCalendarPageState extends State<PatientCalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<Event>> events = {};
  final TextEditingController _eventController = TextEditingController();
  late final ValueNotifier<List<Event>> _selectedEvents;

  CollectionReference eventsCollection =
      FirebaseFirestore.instance.collection('events');

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    _calendarFormat = CalendarFormat.month;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _selectedEvents.value = _getEventsForDay(selectedDay);
      });
    }
  }

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  Stream<QuerySnapshot> eventsCollectionStream =
      FirebaseFirestore.instance.collection('events').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments Calendar'),
      ),
      body: Column(
        children: [
          TableCalendar(
            locale: "en_US",
            firstDay: DateTime.utc(2023, 12, 31),
            lastDay: DateTime.utc(2030, 1, 1),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            calendarFormat: _calendarFormat,
            startingDayOfWeek: StartingDayOfWeek.sunday,
            onDaySelected: (selectedDay1, focusedDay1) {
              _onDaySelected(selectedDay1, focusedDay1);
            },
            eventLoader: _getEventsForDay,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            calendarStyle: const CalendarStyle(
              outsideDaysVisible: false,
              todayDecoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 81, 151),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Color.fromARGB(255, 4, 138, 255),
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(color: Colors.white),
              todayTextStyle: TextStyle(color: Colors.white),
              weekendTextStyle: TextStyle(color: Colors.blue),
            ),
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: eventsCollection.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                List<Event> events = [];

                snapshot.data!.docs.forEach((document) {
                  DateTime date = DateTime.fromMillisecondsSinceEpoch(
                      document['date'].millisecondsSinceEpoch);

                  List<dynamic> eventList = document['events'];

                  if (isSameDay(_selectedDay, date)) {
                    events.addAll(eventList.map((event) {
                      return Event(event['title'] ?? '', date);
                    }));
                  }
                });

                return ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        onTap: () => print("Dr.Appointment"),
                        title: Text('${events[index].title}'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}