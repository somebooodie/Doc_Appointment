import 'package:doc_appointment/app/config/theme/my_colors.dart';
import 'package:doc_appointment/app/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:doc_appointment/app/config/routes/named_routes.dart';

class Medication {
  final String name;
  final String dosage;
  final int quantity;
  final String patient;

  Medication(this.name, this.dosage, this.quantity, this.patient);
}

final medicationProvider =
    StateProvider<StateController<List<Medication>>>((ref) {
  return StateController<List<Medication>>([]);
});

class MedDocAdd extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final dosageController = TextEditingController();
    final quantityController = TextEditingController();
    String? selectedPatient;

    void addMedication() {
      final medication = Medication(
        nameController.text,
        dosageController.text,
        int.tryParse(quantityController.text) ?? 0,
        selectedPatient ?? 'Unknown', // Handle the selected patient here
      );

      // Access the current state and update it
      final currentState = ref.read(medicationProvider.notifier).state;
      final updatedList = List<Medication>.from(currentState.state)
        ..add(medication);

      // Update the state of the medicationProvider
      ref.read(medicationProvider.notifier).state =
          StateController(updatedList);

      // Optionally clear the text fields after adding the medication
      nameController.clear();
      dosageController.clear();
      quantityController.clear();
    }

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
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () =>
              GoRouter.of(context).goNamed(MyNamedRoutes.mdDocPage),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance.collection('users').get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              List<String> usernames = snapshot.data!.docs
                  .map((doc) => doc['username'] as String)
                  .toList();

              return ListView(
                children: [
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                        labelText: 'Patient', border: OutlineInputBorder()),
                    value: selectedPatient,
                    iconEnabledColor: MyColors.blue,
                    hint: Text(
                      'Select Patient',
                      selectionColor: MyColors.blue,
                    ),
                    focusColor: MyColors.blue,
                    onChanged: (String? newValue) {
                      selectedPatient = newValue;
                    },
                    items:
                        usernames.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            color: Colors.blue, // Set text color to blue
                          ),
                        ),
                      );
                    }).toList(),
                    dropdownColor: Colors.white,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Medicine Name',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: dosageController,
                    decoration: InputDecoration(
                      labelText: 'Dosage',
                      labelStyle: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                      suffixText: 'mg every ### hours',
                      suffixStyle: TextStyle(color: Colors.blue),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: quantityController,
                    decoration: InputDecoration(
                      labelText: 'Quantity in Box',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: addMedication,
                    child: Text(
                      'Add Medication',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors
                            .white, // Text color set to white for contrast
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Button color set to blue
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: Text('No users found'));
            }
          },
        ),
      ),
    );
  }
}
