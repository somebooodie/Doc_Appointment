import 'package:doc_appointment/app/config/routes/named_routes.dart';
import 'package:doc_appointment/app/core/extensions/build_context_extension.dart';
import 'package:doc_appointment/app/modules/feature/domain/providers/state/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkIfUserAuthinticated =
        ref.watch(checkIfAuthinticatedFutureProvider);
    // Future<void> navigateToNextScreen() async {
    //   await Future.delayed(Duration(seconds: 20));
    // }

    return Scaffold(
      body: Center(
        child: checkIfUserAuthinticated.when(
          data: (data) {
            if (data.value?.uid != null) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                GoRouter.of(context).goNamed(MyNamedRoutes.login);
              });
            } else {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                GoRouter.of(context).goNamed(MyNamedRoutes.homepage);
              });
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Center(
                    child: Image.asset(
                      'assets/images/dr-appointment-high-resolution-logo.png', // Replace with your [DA] logo asset path
                      width: context.screenHeight * 0.1,
                      height: context.screenHeight * 0.2,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: context.screenHeight * 0.05),
                  child: Image.asset(
                    'assets/images/ypa-main-logo.png', // Replace with your other logo asset path
                    width: context.screenHeight * 0.13,
                    height: context.screenHeight * 0.11,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          },
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
        ),
      ),
    );
  }
}
