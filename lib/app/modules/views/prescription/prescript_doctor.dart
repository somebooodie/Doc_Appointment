import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'hospitals.dart';

class PrescriptionUploadPage extends StatefulWidget {
  @override
  _PrescriptionUploadPageState createState() => _PrescriptionUploadPageState();
}

class _PrescriptionUploadPageState extends State<PrescriptionUploadPage> {
  String? selectedPatient;
  String? selectedGovernance;
  String? selectedHospital;
  final TextEditingController medicationController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    selectedGovernance = Hospitals.getGovernances().first;
    selectedHospital =
        Hospitals.getHospitalsForGovernance(selectedGovernance!).first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Prescription Upload', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection('users').get(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
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
                  return DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                        labelText: 'Patient', border: OutlineInputBorder()),
                    value: selectedPatient,
                    hint: Text('Select Patient'),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedPatient = newValue;
                      });
                    },
                    items:
                        usernames.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    dropdownColor:
                        Colors.blue, // Set the dropdown color to blue
                  );
                } else {
                  return Text("No patients found");
                }
              },
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedGovernance,
              onChanged: (value) {
                setState(() {
                  selectedGovernance = value;
                  selectedHospital =
                      Hospitals.getHospitalsForGovernance(value!).first;
                });
              },
              items: Hospitals.getGovernances()
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Governance'),
            ),
            SizedBox(height: 10),
            if (selectedGovernance != null)
              DropdownButtonFormField<String>(
                value: selectedHospital,
                onChanged: (value) => setState(() => selectedHospital = value),
                items: Hospitals.getHospitalsForGovernance(selectedGovernance!)
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Hospital'),
              ),
            SizedBox(height: 10),
            TextField(
              controller: medicationController,
              decoration: InputDecoration(
                labelText: 'Medication Name',
                border:
                    UnderlineInputBorder(), // Line design for Medication Name
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: double.infinity, // Set the width to your desired size
                height: 60.0, // Set the height to your desired size
                child: ElevatedButton(
                  onPressed: () => sendPrescription(),
                  child: Text(
                    'Send Prescription',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color:
                          Colors.white, // Text color set to white for contrast
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Button color set to blue
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sendPrescription() async {
    if (selectedPatient != null &&
        selectedGovernance != null &&
        selectedHospital != null &&
        medicationController.text.isNotEmpty) {
      await _firestore
          .collection('prescriptions')
          .add({
            'patient': selectedPatient,
            'governance': selectedGovernance,
            'hospital': selectedHospital,
            'medication': medicationController.text,
            'timestamp': FieldValue.serverTimestamp(),
          })
          .then((_) => {
                clearForm(),
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Success"),
                      content: Text("Prescription uploaded successfully."),
                      actions: [
                        TextButton(
                          child: Text("OK"),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    );
                  },
                )
              })
          .catchError((error) => print("Failed to add prescription: $error"));
    } else {
      print("Please fill all the fields");
    }
  }

  void clearForm() {
    setState(() {
      medicationController.clear();
      selectedPatient = null;
      selectedGovernance = Hospitals.getGovernances().first;
      selectedHospital =
          Hospitals.getHospitalsForGovernance(selectedGovernance!).first;
    });
  }
}
