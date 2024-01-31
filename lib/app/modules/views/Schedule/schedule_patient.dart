//import 'package:doc_appointment/app/config/routes/named_routes.dart';
//import 'dart:html';
import 'package:doc_appointment/app/config/theme/my_colors.dart';
import 'package:doc_appointment/app/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class schedulePatient extends ConsumerStatefulWidget {
  schedulePatient({Key? key});
  List<String> list = <String>['One', 'Two', 'Three', 'Four'];

  @override
  ConsumerState<schedulePatient> createState() => _SchedulePatientState();
}

class _SchedulePatientState extends ConsumerState<schedulePatient> {
  String selectedValue = "What is your issue ?";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: context.screenHeight * 0.12,
        title: Image.asset(
          'assets/images/logo.png',
          width: context.screenHeight * 0.05,
          height: context.screenHeight * 0.09,
          fit: BoxFit.cover,
        ),
        centerTitle: true,
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
              child:DropdownButton<String>(
      value: dropdownValue,
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
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
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
              child: Center(child: Text("Hello")),
            ),
            Container(
              width: context.screenWidth * 0.8,
              height: context.screenHeight * 0.07,
              decoration: BoxDecoration(
                border: Border.all(color: MyColors.primary_500),
              ),
              child: Center(child: Text("Hello")),
            ),
            Container(
              width: context.screenWidth * 0.8,
              height: context.screenHeight * 0.07,
              decoration: BoxDecoration(
                border: Border.all(color: MyColors.primary_500),
              ),
              child: Center(child: Text("Hello")),
            ),
            ElevatedButton(
              onPressed: () {
                // Your button click logic here
              },
              style: ElevatedButton.styleFrom(
                primary: MyColors.primary_500,
                onPrimary: MyColors.white,
              ),
              child: Text("Send Request"),
            )
          ],
        ),
      ),
    );
  }
}


//  Expanded(
//               child: Center(
//                 child: Image.asset(
//                   'assets/images/box_meds.png',
//                   width: context.screenHeight * 0.3,
//                   height: context.screenHeight * 0.2,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(bottom: context.screenHeight * 0.09),
//               child: Image.asset(
//                 'assets/images/med_report.png',
//                 width: context.screenHeight * 0.3,
//                 height: context.screenHeight * 0.2,
//                 fit: BoxFit.cover,
//               ),
//             ),