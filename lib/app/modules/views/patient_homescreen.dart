import 'package:doc_appointment/app/config/routes/named_routes.dart';
import 'package:doc_appointment/app/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class patientHomeScreen extends StatelessWidget {
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
              imagePath: 'assets/images/patient_appointment.png',
              text: 'Manage Patient Sessions',
              routeName: MyNamedRoutes.scheduleDoctor,
            ),
            SizedBox(height: context.screenHeight * 0.09),
            _buildSquareButton(
              context: context,
              imagePath: 'assets/images/faq_patient.png',
              text: 'FAQ',
              routeName: MyNamedRoutes.drFAQ,
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
        if (routeName == MyNamedRoutes.schedulePatient) {
          GoRouter.of(context).go('/docHomeScreen/schedulePatient');
        } else if (routeName == MyNamedRoutes.faqPatient) {
          GoRouter.of(context).go('/docHomeScreen/faqPatient');
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
