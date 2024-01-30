import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_appointment/app/modules/feature/domain/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthRepository {
  AuthRepository(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  User? get currentUser => _firebaseAuth.currentUser;

  Future<User?> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String userName,
    required String doctorId,
  }) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // updateDisplayName is not necessary here
      // await userCredential.user!.updateDisplayName(userName);

      // Save user info to Firebase
      await saveUserInfoToFirebase(
        userCredential.user!.uid.toString(),
        userName,
        userCredential.user!.email.toString(),
        doctorId,
        password,
      );

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Wrong password provided for that user.');
      } else {
        throw AuthException(e.message!);
      }
    }
  }

  Future<void> saveUserInfoToFirebase(String userId, String userName,
      String email, String doctorId, String password) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).set(
        {
          'username': userName,
          'email': email,
          'id': userId,
          'password': password,
          'userLocation': null,
          'doctorId': doctorId,
        },
      );

      // // Store additional information specific to the doctor
      // if (doctorId.isNotEmpty) {
      //   await FirebaseFirestore.instance.collection('doctors').doc(doctorId).set(
      //     {
      //       'doctorId': doctorId,
      //       'password': password,
      //       // Add other fields related to the doctor if needed
      //     },
      //   );
      // }
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
    // required String userName,
  }) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;

      // Retrieve additional user information (like displayName)
      if (user != null) {
        await user.reload(); // Reload user data to get the updated info
        await user.getIdToken(); // Refresh the token to get the latest data

        // Now, user.displayName should contain the userName
      }
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Wrong password provided for that user.');
      } else {
        throw AuthException(e.message!);
      }
    }
  }

 

  // Future<void> saveUserInfoToFirebase(String userId, String userName,
  //     String email, String doctorId, String password) async {
  //   try {
  //     await FirebaseFirestore.instance.collection('users').doc(userId).set(
  //       {
  //         'username': userName,
  //         'email': email,
  //         'id': userId,
  //         // 'photo': photoURL,
  //         'password': password,
  //         'userLocation': null,
  //         'doctorId': doctorId, // Add doctorId field
  //       },
  //     );

  //     // Store additional information specific to the doctor
  //     if (doctorId.isNotEmpty) {
  //       await FirebaseFirestore.instance
  //           .collection('doctors')
  //           .doc(doctorId)
  //           .set(
  //         {
  //           'doctorId': doctorId,
  //           'password': password,
  //           // Add other fields related to the doctor if needed
  //         },
  //       );
  //     }
  //   } catch (e) {
  //     throw AuthException(e.toString());
  //   }
  // }

  Future<MyUser?> fetchUserById(String userId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: userId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        MyUser user = MyUser.fromMap(
          querySnapshot.docs.first.data() as Map<String, dynamic>,
        );
        return user;
      } else {
        return null; // No user found with the specified ID
      }
    } catch (e) {
      debugPrint('Error fetching user: $e');
      return null;
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
