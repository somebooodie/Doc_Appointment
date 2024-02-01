import 'package:doc_appointment/app/config/routes/named_routes.dart';
import 'package:doc_appointment/app/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class mdDocPage extends StatelessWidget {
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
        centerTitle: true, // Centers the title image
      ),
      body: Center(
        // Center the content
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSquareButton(
              context: context,
              imagePath: 'assets/images/box_meds.png',
              text: 'Add meds By Docotor',
              routeName: MyNamedRoutes.medDocAdd,
            ),
            SizedBox(height: context.screenHeight * 0.09),
            _buildSquareButton(
              context: context,
              imagePath: 'assets/images/med_report.png',
              text: 'write prescription by Docotor',
              routeName: MyNamedRoutes.prescriptionDocPage,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSquareButton({
    required BuildContext context,
    required String imagePath,
    required String text,
    required String routeName,
  }) {
    return InkWell(
      onTap: () {
        // Check if it's a nested route and use the full path
        if (routeName == MyNamedRoutes.medDocAdd) {
          GoRouter.of(context).pushNamed(MyNamedRoutes.medDocAdd);
        } else if (routeName == MyNamedRoutes.prescriptionDocPage) {
          GoRouter.of(context).go('/mdDocPage/prescriptionDocPage');
        } else {
          GoRouter.of(context).go(routeName);
        }
      },
      child: Container(
        width: context.screenHeight * 0.3,
        height: context.screenHeight * 0.3, // Making the container square
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: context.screenHeight * 0.2,
              height: context.screenHeight * 0.2,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(text),
            ),
          ],
        ),
      ),
    );
  }
}


// import 'package:doc_appointment/app/core/extensions/build_context_extension.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class mdDocPage extends ConsumerWidget {
//   const mdDocPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: context.screenHeight * 0.12,
//         title: Image.asset(
//           'assets/images/logo.png', // Replace with your [DA] logo asset path
//           width: context.screenHeight * 0.05,
//           height: context.screenHeight * 0.09,
//           fit: BoxFit.cover,
//         ),
//         centerTitle: true, // This will center the title image
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
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
//           ],
//         ),
//       ),
//     );
//   }
// }


