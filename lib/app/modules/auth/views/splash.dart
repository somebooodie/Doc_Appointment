import 'package:doc_appointment/app/config/routes/named_routes.dart';
import 'package:doc_appointment/app/core/extensions/build_context_extension.dart';
import 'package:doc_appointment/app/modules/auth/domain/providers/state/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkIfUserAuthinticated =
        ref.watch(checkIfAuthinticatedFutureProvider);

    // Introduce a delay of 3 seconds before checking the condition
    Future<void> navigateToNextScreen() async {
      await Future.delayed(Duration(seconds: 2));
      // After the delay, check the condition and navigate accordingly
      final userAuthState = checkIfUserAuthinticated.value;
      if (userAuthState is AsyncData<User?> &&
          userAuthState.value?.uid != null) {
        GoRouter.of(context).goNamed(MyNamedRoutes.login);
      } else {
        GoRouter.of(context).goNamed(MyNamedRoutes.homepage);
      }
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
                  'assets/images/dr-appointment-favicon-color.png', // Replace with your [DA] logo asset path
                  width: context.screenHeight * 0.1,
                  height: context.screenHeight * 0.2,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: context.screenHeight * 0.05),
              child: Image.asset(
                'assets/images/Screenshot 2024-01-24 at 10.31.01 AM.png', // Replace with your other logo asset path
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
