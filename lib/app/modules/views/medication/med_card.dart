import 'package:doc_appointment/app/modules/views/medication/med_list.dart';
import 'package:flutter/material.dart';

class MedicationCard extends StatelessWidget {
  final Medication med;

  MedicationCard({required this.med});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                med.name,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${med.dosage}',
                  style: TextStyle(color: Colors.blue, fontSize: 11.0),
                ),
                SizedBox(height: 4.0),
                Text(
                  'Tablets in box: ${med.quantity}',
                  style: TextStyle(color: Colors.blue, fontSize: 11.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
