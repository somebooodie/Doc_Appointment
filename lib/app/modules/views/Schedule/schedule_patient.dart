//import 'package:doc_appointment/app/config/routes/named_routes.dart';
//import 'dart:html';

import 'package:doc_appointment/app/config/routes/named_routes.dart';
import 'package:doc_appointment/app/config/theme/my_colors.dart';
import 'package:doc_appointment/app/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class schedulePatient extends StatefulWidget {
  const schedulePatient({super.key});

  @override
  State<schedulePatient> createState() => _schedulePatientState();
}

class _schedulePatientState extends State<schedulePatient> {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: context.screenWidth * 0.8,
              height: context.screenHeight * 0.07,
              decoration: BoxDecoration(
                border: Border.all(color: MyColors.primary_500),
              ),
              child: DropdownButton<String>(
                value: issues,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    issues = value!;
                  });
                },
                items: issuesList.map<DropdownMenuItem<String>>((String value) {
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
                value: prefDays,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    prefDays = value!;
                  });
                },
                items: daysList.map<DropdownMenuItem<String>>((String value) {
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
                value: prefTime,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    prefTime = value!;
                  });
                },
                items: timeList.map<DropdownMenuItem<String>>((String value) {
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
                value: prefArea,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    prefArea = value!;
                  });
                },
                items: areaList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (issues == "What is your issue?" ||
                    prefDays == "Preferred Days of Week ?" ||
                    prefTime == "Preferred time?" ||
                    prefArea == "Preferred area?") {
                } else {

                  GoRouter.of(context).pushNamed(MyNamedRoutes.DocList);
                }
              },
              style: ElevatedButton.styleFrom(
                primary: MyColors.primary_500, // Background color of the button
                onPrimary: MyColors.white, // Text color of the button
              ),
              child: Text("Send Request"),
            )
          ],
        ),
      ),
    );
  }
}

