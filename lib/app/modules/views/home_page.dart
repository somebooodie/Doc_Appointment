import 'package:doc_appointment/app/config/routes/named_routes.dart';
import 'package:doc_appointment/app/core/extensions/build_context_extension.dart';
import 'package:doc_appointment/app/modules/feature/domain/providers/state/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkIfUserAuthenticated =
        ref.watch(checkIfAuthinticatedFutureProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: context.screenHeight * 0.12,
        title: Image.asset(
          'assets/images/Screenshot 2024-01-24 at 10.26.03 AM.png', // Replace with your [DA] logo asset path
          width: context.screenHeight * 0.05,
          height: context.screenHeight * 0.09,
          fit: BoxFit.cover,
        ),
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
        child: checkIfUserAuthenticated.when(
          data: (data) {
            if (data.value?.uid != null) {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                // Go to patient login page
                // GoRouter.of(context).goNamed(MyNamedRoutes.patientlogin);
              });
            } else {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                // Go to login page
                // GoRouter.of(context).goNamed(MyNamedRoutes.login);
              });
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        GoRouter.of(context).goNamed(MyNamedRoutes.login);
                      },
                      child: Image.asset(
                        'assets/images/Screenshot 2024-01-24 at 12.06.57 PM.png',
                        width: context.screenHeight * 0.3,
                        height: context.screenHeight * 0.2,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: context.screenHeight * 0.09),
                  child: Image.asset(
                    'assets/images/Screenshot 2024-01-24 at 12.07.28 PM.png',
                    width: context.screenHeight * 0.3,
                    height: context.screenHeight * 0.2,
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
