import 'package:doc_appointment/app/config/routes/named_routes.dart';
import 'package:doc_appointment/app/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Introduce a delay of 3 seconds before navigating
    Future<void> navigateToNextScreen() async {
      await Future.delayed(const Duration(seconds: 2)); // Delay for 3 seconds
      // Navigate to docHomeScreen after the delay
      GoRouter.of(context).goNamed(MyNamedRoutes.patientHomeScreen);
    }

    // Call the navigateToNextScreen function when the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      navigateToNextScreen();
    });

    // Return the splash screen widget
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/images/logo.png', // Replace with your logo asset path
                  width: context.screenHeight * 0.1,
                  height: context.screenHeight * 0.2,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: context.screenHeight * 0.05),
              child: Image.asset(
                'assets/images/ypa_logo_2.png', // Replace with your other logo asset path
                width: context.screenHeight * 0.13,
                height: context.screenHeight * 0.11,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}