//import 'package:doc_appointment/app/config/routes/named_routes.dart';
//import 'dart:html';

import 'package:doc_appointment/app/config/routes/named_routes.dart';
import 'package:doc_appointment/app/config/theme/my_colors.dart';
import 'package:doc_appointment/app/core/extensions/build_context_extension.dart';
import 'package:doc_appointment/app/modules/auth/domain/providers/state/state_schedule_pateint.dart';
import 'package:doc_appointment/app/modules/views/Schedule/doctor_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SchedulePatient extends StatefulWidget {
  const SchedulePatient({super.key});

  @override
  State<SchedulePatient> createState() => _SchedulePatientState();
}

class _SchedulePatientState extends State<SchedulePatient> {
  String issues = "What is your issue?";
  List<String> issuesList = <String>[
    'What is your issue?',
    'Orthopedics',
    'Cardiology',
    'Ophthalmology',
    'Gastroenterology',
    'Dermatology'
  ];
  String prefDays = "Preferred Days of Week ?";
  List<String> daysList = <String>[
    'Preferred Days of Week ?',
    'Weekends',
    'Weekdays',
  ];
  String prefTime = "Preferred time?";
  List<String> timeList = <String>[
    'Preferred time?',
    'Evening',
    'Morning',
    'Afternoon'
  ];

  String prefArea = "Preferred area?";
  List<String> areaList = <String>[
    'Preferred area?',
    'Jahra',
    'Assima',
    'Hawally'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: context.screenHeight * 0.12,
        title: Image.asset(
          'assets/images/logo.png', // Replace with your [DA] logo asset path
          width: context.screenHeight * 0.05,
          height: context.screenHeight * 0.09,
          fit: BoxFit.cover,
        ),
        centerTitle: true, // This will center the title image
      ),
      body: Center(
        child: Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(schedulePatientProvider);

            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: context.screenWidth * 0.8,
                  height: context.screenHeight * 0.07,
                  decoration: BoxDecoration(
                    border: Border.all(color: MyColors.primary_500),
                  ),
                  child: DropdownButton<String>(
                    value: state.issues,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? value) {
                      ref
                          .read(schedulePatientProvider.notifier)
                          .setIssues(value!);
                    },
                    items: state.issuesList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  width: context.screenWidth * 0.8,
                  height: context.screenHeight * 0.07,
                  decoration: BoxDecoration(
                    border: Border.all(color: MyColors.primary_500),
                  ),
                  child: DropdownButton<String>(
                    value: state.prefTime,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? value) {
                      ref
                          .read(schedulePatientProvider.notifier)
                          .setPrefTime(value!);
                    },
                    items: state.timeList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  width: context.screenWidth * 0.8,
                  height: context.screenHeight * 0.07,
                  decoration: BoxDecoration(
                    border: Border.all(color: MyColors.primary_500),
                  ),
                  child: DropdownButton<String>(
                    value: state.prefDays,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? value) {
                      ref
                          .read(schedulePatientProvider.notifier)
                          .setPrefDays(value!);
                    },
                    items: state.daysList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  width: context.screenWidth * 0.8,
                  height: context.screenHeight * 0.07,
                  decoration: BoxDecoration(
                    border: Border.all(color: MyColors.primary_500),
                  ),
                  child: DropdownButton<String>(
                    value: state.prefArea,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? value) {
                      ref
                          .read(schedulePatientProvider.notifier)
                          .setPrefArea(value!);
                    },
                    items: state.areaList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                // ... Repeat similar pattern for other DropdownButtons
                ElevatedButton(
                  onPressed: () {
                    // Access state.issues, state.prefDays, state.prefTime, state.prefArea
                    if (state.issues == "What is your issue?" ||
                        state.prefDays == "Preferred Days of Week ?" ||
                        state.prefTime == "Preferred time?" ||
                        state.prefArea == "Preferred area?") {
                      // Handle validation logic
                    } else {
                      // Perform navigation or other actions
                      state.filtered = doctorsList
                          .where((doctor) =>
                              (doctor['area'] == state.prefArea &&
                                  doctor['specialty'] == state.issues &&
                                  doctor['availability'] == state.prefTime &&
                                  doctor['schedule'] == state.prefDays))
                          .toList();

                      GoRouter.of(context).pushNamed(MyNamedRoutes.DocList);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary:
                        MyColors.primary_500, // Background color of the button
                    onPrimary: MyColors.white, // Text color of the button
                  ),
                  child: Text("Search"),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
