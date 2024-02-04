import 'package:flutter/material.dart';

class Hospitals {
  static final List<String> governances = [
    'Al Ahmadi', 'Al Asimah', 'Al Farwaniyah', 'Al Jahra', 'Hawalli', 'Mubarak Al-Kabeer'
  ];

  static final Map<String, List<String>> hospitalsByGovernance = {
    'Al Ahmadi': ['Adan Hospital', 'Al Ahmadi Hospital', 'The New Al Ahmadi Hospital', 'Fahaheel Al-Dawhah Hospital', 'Al-Sabah Specialty Medical Center'],
    'Al Asimah': ['Amiri Hospital', 'Mubarak Al-Kabeer Hospital', 'Al-Sabah Hospital', 'Ibn Sina Hospital', 'Al-Razi Hospital'],
    'Al Farwaniyah': ['Farwaniya Hospital', 'Al-Jahra Hospital', 'Sabah Al-Nasser Medical Center', 'Al-Farwaniyah Maternity Hospital', 'Kuwait Center for Mental Health'],
    'Al Jahra': ['Jahra Hospital', 'New Jahra Medical City', 'Tertiary Care Center', 'Al-Tal Medical Clinic', 'Saad Al Abdullah Health Center'],
    'Hawalli': ['Mowasat Hospital', 'Royale Hayat Hospital', 'Dar Al Shifa Hospital', 'Hawalli Pediatric Hospital', 'Al-Salam International Hospital'],
    'Mubarak Al-Kabeer': ['Adan Hospital', 'Mubarak Al-Kabeer Hospital', 'Jabriya Dermatology Hospital', 'The New Mubarak Al-Kabeer Hospital', 'Hadi Clinic'],
  };

  static List<String> getGovernances() {
    return governances;
  }

  static List<String> getHospitalsForGovernance(String governance) {
    return hospitalsByGovernance[governance] ?? [];
  }
}

class PrescriptionPatientPage extends StatelessWidget {
  final List<String> medications = [
    'Azacitidine (Vidaza)',
    'Allopurinol',
    'Amitriptyline',
    'Acyclovir',
    'Amlodipine',
    'Adalimumab',
    'Atorvastatin'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prescriptions'),
      ),
body: ListView.builder(
  itemCount: medications.length + 1, // Increase the item count by 1 for the specific card
  itemBuilder: (context, index) {
    // Check if the current index is for the specific card
    if (index == medications.length) {
      // Return the specific card for Augmentin
      return Card(
        child: ListTile(
          title: Text('Augmentin'),
          subtitle: Text('Governance: Al Jahra\nHospital: Al-Jahra Hospital'),
        ),
      );
    } else {
      // Generate random governance and hospital for other medications
      String randomGovernance = (Hospitals.governances..shuffle()).first;
      String randomHospital = (Hospitals.getHospitalsForGovernance(randomGovernance)..shuffle()).first;

      return Card(
        child: ListTile(
          title: Text(medications[index]),
          subtitle: Text('Governance: $randomGovernance\nHospital: $randomHospital'),
        ),
      );
    }
  },
),
    );
  }
}
