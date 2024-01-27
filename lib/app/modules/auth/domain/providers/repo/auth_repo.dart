//import 'package:chater/app/modules/auth/domain/models/auth_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthRepository {
  AuthRepository(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  User? get currentUser => _firebaseAuth.currentUser;

  Future<User?> createUserWithEmailAndPassword(
      {required String email,
      required String password,
      required String userName,
      String? docId}) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await saveUserInfoToFirebase(
        userCredential.user!.uid.toString(),
        userName,
        userCredential.user!.email.toString(),
        userCredential.user!.photoURL.toString(),
        docId,
      );

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('No user found for this email.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Wrong password provided for the user.');
      } else {
        throw AuthException(e.message!);
      }
    }
  }

  Future<void> saveUserInfoToFirebase(
      String userId, String userName, String email, String photoURL,
      [String? docId]) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).set(
        {
          'username': userName,
          'email': email,
          "id": userId,
          'photo': photoURL,
          'userLocation': null,
          'docId': docId,
        },
      );
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('No user found for this email.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Wrong password provided for the user.');
      } else {
        throw AuthException(e.message!);
      }
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      debugPrint(e.toString());
      throw AuthException(e.toString());
    }
  }
}

class AuthException implements Exception {
  AuthException(this.message);

  final String message;

  @override
  String toString() => message;
}
