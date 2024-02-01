import 'package:doc_appointment/app/modules/views/medication/med_card.dart';
import 'package:doc_appointment/app/modules/views/medication/med_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:doc_appointment/app/config/routes/named_routes.dart';
import 'package:doc_appointment/app/core/extensions/build_context_extension.dart';

class MedBoxPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medicationList = ref.watch(medicationProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: context.screenHeight * 0.12,
        title: Image.asset(
          'assets/images/logo.png', // Replace with your logo asset path
          width: context.screenHeight * 0.05,
          height: context.screenHeight * 0.09,
          fit: BoxFit.cover,
        ),
        centerTitle: true, // This will center the title image
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () =>
              GoRouter.of(context).goNamed(MyNamedRoutes.mdPatientPage),
        ),
      ),
      body: ListView.builder(
        itemCount: medicationList.state.length,
        itemBuilder: (context, index) {
          return MedicationCard(med: medicationList.state[index]);
        },
      ),
    );
  }
}
// class Medication {
//   final String name;
//   final String dosage;
//   final int tabletsInBox;

//   Medication(this.name, this.dosage, this.tabletsInBox);
// }

// class MedicationCard extends StatelessWidget {
//   final Medication med;

//   const MedicationCard({Key? key, required this.med}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               child: Text(
//                 med.name,
//                 style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Text(
//                   '${med.dosage}',
//                   style: TextStyle(color: Colors.blue, fontSize: 11.0),
//                 ),
//                 SizedBox(height: 4.0),
//                 Text(
//                   'Tablets in box: ${med.tabletsInBox}',
//                   style: TextStyle(color: Colors.purple, fontSize: 11.0),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
