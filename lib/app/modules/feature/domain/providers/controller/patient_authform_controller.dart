import 'package:doc_appointment/app/modules/feature/domain/providers/state/patient_auth_state.dart';
import 'package:doc_appointment/app/modules/feature/domain/providers/repo/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthController extends StateNotifier<AuthState> {
  AuthController(super.state, this._authRepository);
  final AuthRepository _authRepository;

  Future<bool> register(
      {required String email,
      required String userName,
      required String password,
      required String doctorId
      }) async {
    state = state.copyWith(isLoading: true);
    try {
      User? user = await _authRepository.createUserWithEmailAndPassword(
          email: email, password: password, userName: userName ,doctorId: doctorId);
      if (user != null) {
        await user.updateDisplayName(userName);
        state = state.copyWith(isLoading: false, isAuth: true);
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<bool> login({
    required String email,
    required String password,
    // required String userName
  }) async {
    state = state.copyWith(isLoading: true);
    try {
      User? user = await _authRepository.signInWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        state = state.copyWith(isLoading: false, isAuth: true);
        return true;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
    return false;
  }

  Future<bool> signOut() async {
    try {
      await _authRepository.signOut();
      state = state.copyWith(
        isAuth: false,
        error: null,
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}
