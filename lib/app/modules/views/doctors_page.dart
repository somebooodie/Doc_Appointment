import 'package:doc_appointment/app/core/extensions/build_context_extension.dart';
import 'package:doc_appointment/app/modules/lists/doctor_list.dart';
import 'package:flutter/material.dart';
import 'package:doc_appointment/app/modules/views/Schedule/schedule_patient.dart';

class DoctorNamesListView extends StatelessWidget {
  DoctorNamesListView({Key? key}) : super(key: key);

  //final List<Map<String, dynamic>> doctorsList;
  @override
  List<Map<String, dynamic>> filtered = doctorsList
      .where((doctor) =>
          (doctor['area'] == 'Assima' && doctor['specialty'] == 'Orthopedics'))
      .toList();
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
      body: ListView.builder(
        itemCount: filtered.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(filtered[index]['name']),
            subtitle: Text(filtered[index]['specialty']),
          );
        },
      ),
    );
  }
}
