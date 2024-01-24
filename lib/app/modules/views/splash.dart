import 'package:doc_appointment/app/config/routes/named_routes.dart';
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
    return Scaffold(
      body: Center(
        child: checkIfUserAuthinticated.when(
          data: (data) {
            if (data.value?.uid != null) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                GoRouter.of(context).goNamed(MyNamedRoutes.chats);
              });
            } else {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                GoRouter.of(context).goNamed(MyNamedRoutes.patientlogin);
              });
            }
            return Center(child: Text("Spash"));
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
