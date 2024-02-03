import 'package:doc_appointment/app/modules/auth/domain/providers/controller/doc_authform_controller.dart';
import 'package:doc_appointment/app/modules/auth/domain/providers/controller/patient_authform_controller.dart';
import 'package:doc_appointment/app/modules/auth/domain/providers/controller/text_form_provider.dart';
import 'package:doc_appointment/app/modules/auth/domain/providers/repo/auth_repo.dart';
import 'package:doc_appointment/app/modules/auth/domain/providers/state/patient_auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final authFormController =
    ChangeNotifierProvider((ref) => MyAuthFormController());

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(FirebaseAuth.instance);
});

final authStateProvider = StreamProvider<User?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  ref.read(authControllerProvider);
  return authRepository.authStateChanges;
});
final authControllerProvider = StateNotifierProvider<PatientAuthController, AuthState>(
  (ref) {
    return PatientAuthController(
      AuthState(),
      ref.watch(authRepositoryProvider),
    );
  },
);
final checkIfAuthinticatedFutureProvider =
    FutureProvider((ref) => ref.watch(authStateProvider));
