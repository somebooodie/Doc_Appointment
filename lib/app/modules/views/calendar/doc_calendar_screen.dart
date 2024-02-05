import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_appointment/app/config/theme/my_colors.dart';
import 'package:doc_appointment/app/modules/views/calendar/event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class DoctorCalendarScreen extends StatefulWidget {
  const DoctorCalendarScreen({super.key});

  @override
  _DoctorCalendarPageState createState() => _DoctorCalendarPageState();
}

class _DoctorCalendarPageState extends State<DoctorCalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<Event>> events = {};
  final TextEditingController _eventController = TextEditingController();
  late final ValueNotifier<List<Event>> _selectedEvents;
  final currentuser = FirebaseAuth.instance.currentUser;

  CollectionReference eventsCollection =
      FirebaseFirestore.instance.collection('events');

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    _calendarFormat = CalendarFormat.month;

    eventsCollectionStream = FirebaseFirestore.instance
        .collection('events')
        .where('username', isEqualTo: currentuser?.displayName.toString())
        .snapshots();
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

  Future<void> _addEventToFirebase(
      DateTime selectedDay, String title, String username) async {
    try {
      QuerySnapshot querySnapshot = await eventsCollection
          .where('date', isEqualTo: Timestamp.fromDate(selectedDay))
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        List<dynamic> existingEvents = documentSnapshot['events'] ?? [];

        existingEvents.add({'title': title});

        await eventsCollection
            .doc(documentSnapshot.id)
            .update({'events': existingEvents});
      } else {
        await eventsCollection.add({
          'date': Timestamp.fromDate(selectedDay),
          'username': currentuser!.displayName.toString(),
          'events': [
            {'title': title},
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
                        _selectedDay!: [
                          Event(_eventController.text, _selectedDay!,
                              currentuser!.displayName.toString())
                        ]
                      });
                      Navigator.of(context).pop();
                      _selectedEvents.value = _getEventsForDay(_selectedDay!);
                      _addEventToFirebase(
                          _selectedDay ?? DateTime.now(),
                          _eventController.text,
                          currentuser!.displayName.toString());
                      _eventController.clear();
                    },
                    child: const Text("Submit"),
                    style: ElevatedButton.styleFrom(
                        primary: MyColors.white,
                        backgroundColor: (MyColors.white) // Update color
                        ),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: MyColors.primary_500,
        // Update color
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Container(
          color: MyColors.white,
          child: Column(
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
                      DateTime dates = DateTime.fromMillisecondsSinceEpoch(
                          document['date'].millisecondsSinceEpoch);

                      List<dynamic> eventList = document['events'];

                      if (isSameDay(_selectedDay, dates)) {
                        events.addAll(eventList.map((event) {
                          return Event(event['title'] ?? '', dates,
                              event['username'] ?? '');
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
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            onTap: () => print("Dr.Appointment"),
                            title: Text(
                              '${events[index].title}',
                              style: TextStyle(
                                  color:
                                      Colors.blue), // Set text color to white
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
