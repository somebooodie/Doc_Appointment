import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PrescriptionPatientPage extends StatefulWidget {
  @override
  _PrescriptionPatientPageState createState() => _PrescriptionPatientPageState();
}

class _PrescriptionPatientPageState extends State<PrescriptionPatientPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prescription Patient Page', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('prescriptions').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var doc = snapshot.data!.docs[index];
                if (_auth.currentUser!.uid == doc['patient']) {
                  return ListTile(
                    title: Text('Medication: ${doc['medication']}'),
                    subtitle: Text('Governance: ${doc['governance']}\nHospital: ${doc['hospital']}'),
                  );
                } else {
                  return Container();
                }
              },
            );
          } else {
            return Text("No prescriptions found");
          }
        },
      ),
    );
  }
}
