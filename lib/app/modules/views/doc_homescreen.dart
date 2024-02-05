import 'package:doc_appointment/app/config/routes/named_routes.dart';
import 'package:doc_appointment/app/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DocHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: context.screenHeight * 0.15,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Image.asset(
          'assets/images/logo.png',
          width: context.screenHeight * 0.12,
          height: context.screenHeight * 0.12,
          fit: BoxFit.cover,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: IconButton(
              onPressed: () {
                GoRouter.of(context).goNamed(MyNamedRoutes.DocProfileScreen);
              },
              icon: Icon(
                Icons.account_circle,
                color: Colors.blue,
                size: context.screenHeight * 0.045,
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
              imagePath:
                  'assets/images/overhead-view-stethoscope-near-ecg-paper-graph-report-blue-backdrop.jpg',
              text: 'Manage Patient Sessions by Doctor',
              routeName: MyNamedRoutes.scheduleDoctor,
            ),
            _buildSquareButton(
              context: context,
              imagePath:
                  'assets/images/doctors-day-curly-handsome-cute-guy-medical-uniform-thinking-looking-far.jpg',
              text: 'Answer FAQ by Doctor',
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
        if (routeName == MyNamedRoutes.scheduleDoctor) {
          GoRouter.of(context).go('/docHomeScreen/scheduleDoctor');
        } else if (routeName == MyNamedRoutes.faqDoctor) {
          GoRouter.of(context).pushNamed(MyNamedRoutes.faqDoctor);
        } else if (routeName == MyNamedRoutes.DocProfileScreen) {
          GoRouter.of(context).go('/docHomeScreen/DocProfileScreen');
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
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            Container(
              width: double.infinity, // Take the full width
              height: context.screenWidth * 0.6,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: double.infinity, // Take the full width
              height: context.screenWidth * 0.6,

              decoration: BoxDecoration(
                color:
                    Colors.black.withOpacity(0.2), // Adjust opacity as needed
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Center(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
