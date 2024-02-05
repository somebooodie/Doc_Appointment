import 'package:doc_appointment/app/config/routes/named_routes.dart';
import 'package:doc_appointment/app/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PatientHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: context.screenHeight * 0.12,
        backgroundColor: Colors.white, // Set background color to white
        elevation: 0, // Remove elevation
        title: Image.asset(
          'assets/images/logo.png',
          width: context.screenHeight * 0.1,
          height: context.screenHeight * 0.06,
          fit: BoxFit.cover,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: IconButton(
              onPressed: () {
                GoRouter.of(context)
                    .goNamed(MyNamedRoutes.PatientProfileScreen);
              },
              icon: Icon(
                Icons.account_circle,
                color: Colors.blue, // Profile icon color
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSquareButton(
              context: context,
              imagePath: 'assets/images/patient_appointment.png',
              text: 'Book Appointment for Patient',
              routeName: MyNamedRoutes.schedulePatient,
            ),
            SizedBox(height: context.screenHeight * 0.05),
            _buildSquareButton(
              context: context,
              imagePath: 'assets/images/faq_patient.png',
              text: 'Ask FAQ for Patient',
              routeName: MyNamedRoutes.faqPatient,
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
        if (routeName == MyNamedRoutes.schedulePatient) {
          GoRouter.of(context).push('/patientHomeScreen/schedulePatient');
        } else if (routeName == MyNamedRoutes.faqPatient) {
          GoRouter.of(context).push('/patientHomeScreen/faqPatient');
        } else if (routeName == MyNamedRoutes.PatientProfileScreen) {
          GoRouter.of(context).push('/patientHomeScreen/profile');
        } else {
          GoRouter.of(context).go(routeName);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            width: context.screenWidth * 0.6,
            height: context.screenWidth * 0.6,
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  imagePath,
                  width: context.screenWidth * 0.4,
                  height: context.screenWidth * 0.4,
                  fit: BoxFit.cover,
                ),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
