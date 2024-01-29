import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_appointment/app/modules/views/calendar/event.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class docCalendarScreen extends StatefulWidget {
  const docCalendarScreen({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<docCalendarScreen> {
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
    _loadEventsFromFirebase();
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

  Future<void> _loadEventsFromFirebase() async {
    try {
      QuerySnapshot querySnapshot = await eventsCollection.get();

      querySnapshot.docs.forEach((document) {
        DateTime date = DateTime.fromMillisecondsSinceEpoch(
            document['date'].millisecondsSinceEpoch);

        List<dynamic> eventList = document['events'];

        List<Event> events =
            eventList.map((event) => Event(event['title'] ?? '')).toList();

        events.forEach((event) {
          events.addAll({
            date: [event]
          } as Iterable<Event>);
        });
      });

      _selectedEvents.value = _getEventsForDay(_selectedDay!);
    } catch (e) {
      print("Error loading events: $e");
    }
  }

  Future<void> _addEventToFirebase(DateTime selectedDay, String title) async {
    try {
      // Check if the document already exists for the selected day
      QuerySnapshot querySnapshot = await eventsCollection
          .where('date', isEqualTo: Timestamp.fromDate(selectedDay))
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Update existing document
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        List<dynamic> existingEvents = documentSnapshot['events'] ?? [];

        existingEvents.add({'title': title});

        await eventsCollection
            .doc(documentSnapshot.id)
            .update({'events': existingEvents});
      } else {
        // Create a new document
        await eventsCollection.add({
          'date': Timestamp.fromDate(selectedDay),
          'events': [
            {'title': title}
          ]
        });
      }
    } catch (e) {
      print("Error adding event: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments Calendar'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  scrollable: true,
                  title: const Text("Booked Appointment"),
                  content: Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                      controller: _eventController,
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        events.addAll({
                          _selectedDay!: [Event(_eventController.text)]
                        });
                        Navigator.of(context).pop();
                        _selectedEvents.value = _getEventsForDay(_selectedDay!);
                      },
                      child: const Text("Submit"),
                    ),
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          TableCalendar(
            locale: "en_US",
            firstDay: DateTime.utc(2023, 12, 31),
            lastDay: DateTime.utc(2030, 1, 1),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
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
            child: ValueListenableBuilder<List<Event>>(
                valueListenable: _selectedEvents,
                builder: (context, value, _) {
                  return ListView.builder(
                      itemCount: value.length,
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
                            title: Text('${value[index].title}'),
                          ),
                        );
                      });
                }),
          )
        ],
      ),
    );
  }
}