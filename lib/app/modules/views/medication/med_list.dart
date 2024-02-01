import 'package:flutter_riverpod/flutter_riverpod.dart';

class Medication {
  final String name;
  final String dosage;
  final int quantity;

  Medication(this.name, this.dosage, this.quantity);
}

final medicationProvider = StateProvider<StateController<List<Medication>>>((ref) => StateController<List<Medication>>([
  Medication('Acetaminophen', '650 mg every 4-6 hours',
        24), // Assuming 24 tablets per box
    Medication('Ibuprofen', '200-400 mg every 4-6 hours',
        24), // Assuming 24 tablets per box
    Medication('Aspirin', '81-325 mg every 4-6 hours', 100), // As per [14]
    Medication(
        'Lisinopril', '10-20 mg once daily', 30), // Assuming 30 tablets per box
    Medication('Atorvastatin (Lipitor)', '10-80 mg once daily',
        30), // Assuming 30 tablets per box
    Medication('Metformin', '500-1000 mg twice daily',
        60), // Assuming 60 tablets per box
    Medication('Amlodipine (Norvasc)', '5-10 mg once daily',
        30), // Assuming 30 tablets per box
    Medication('Simvastatin (Zocor)', '10-80 mg once daily',
        30), // Assuming 30 tablets per box
    Medication('Levothyroxine', '0.05-0.2 mg once daily',
        30), // Assuming 30 tablets per box
    Medication('Amoxicillin', '500 mg every 8 hours',
        21),


    ]));
