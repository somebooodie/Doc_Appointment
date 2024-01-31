import 'package:doc_appointment/app/config/routes/named_routes.dart';
import 'package:doc_appointment/app/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DocHomeScreen extends StatelessWidget {
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
        actions: [
          // Profile Icon
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: IconButton(
              onPressed: () {
                GoRouter.of(context).goNamed(MyNamedRoutes
                    .profile); // Add your profile navigation logic here
              },
              icon: Icon(Icons.account_circle),
            ),
          ),
        ],
      ),
      body: Center(
        // Center the content
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSquareButton(
              context: context,
              imagePath: 'assets/images/doctor_appointment.png',
              text: 'Manage Patient Sessions',
              routeName: MyNamedRoutes.scheduleDoctor,
            ),
            SizedBox(height: context.screenHeight * 0.09),
            _buildSquareButton(
              context: context,
              imagePath: 'assets/images/faq_doctor.png',
              text: 'Answer FAQ',
              routeName: MyNamedRoutes.faqDoctor,
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
        if (routeName == MyNamedRoutes.scheduleDoctor) {
          GoRouter.of(context).go('/docHomeScreen/scheduleDoctor');
        } else if (routeName == MyNamedRoutes.faqDoctor) {
          GoRouter.of(context).go('/faqDoctor');
        } else if (routeName == MyNamedRoutes.profile) {
          GoRouter.of(context).go('/docHomeScreen/profile');
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


// //import 'package:doc_appointment/app/config/routes/named_routes.dart';
// import 'package:doc_appointment/app/core/extensions/build_context_extension.dart';
// import 'package:doc_appointment/app/modules/auth/domain/providers/state/auth_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';

// // ignore: camel_case_types
// class DocHomeScreen extends ConsumerWidget {
//   const DocHomeScreen({Key? key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final checkIfUserAuthenticated =
//         ref.watch(checkIfAuthinticatedFutureProvider);

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
//         child: checkIfUserAuthenticated.when(
//           data: (data) {
//             if (data.value?.uid != null) {
//               WidgetsBinding.instance.addPostFrameCallback((_) {
//                 // Go to patient login page
//                 // GoRouter.of(context).goNamed(MyNamedRoutes.patientlogin);
//               });
//             } else {
//               WidgetsBinding.instance.addPostFrameCallback((_) {
//                 // Go to login page
//                 // GoRouter.of(context).goNamed(MyNamedRoutes.login);
//               });
//             }

//             return Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Center(
//                     child: Image.asset(
//                       'assets/images/doctor_appointment.png',
//                       width: context.screenHeight * 0.3,
//                       height: context.screenHeight * 0.2,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(bottom: context.screenHeight * 0.09),
//                   child: Image.asset(
//                     'assets/images/faq_doctor.png',
//                     width: context.screenHeight * 0.3,
//                     height: context.screenHeight * 0.2,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ],
//             );
//           },
//           loading: () => Center(child: CircularProgressIndicator()),
//           error: (error, stackTrace) => Center(
//             child: Text(error.toString()),
//           ),
//         ),
//       ),
//     );
//   }
// }
