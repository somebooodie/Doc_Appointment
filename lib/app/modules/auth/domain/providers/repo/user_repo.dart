import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_appointment/app/modules/feature/domain/models/User_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// class UserRepo {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<List<MyUser>> fetchRegisteredUsers() async {
//     try {
//       QuerySnapshot querySnapshot = await _firestore.collection('users').get();
//       List<MyUser> userList = querySnapshot.docs
//           .map((doc) => MyUser.fromMap(doc.data() as Map<String, dynamic>))
//           .toList();

//       return userList;
//     } catch (e) {
//       debugPrint('Error fetching users: $e');
//       return [];
//     }
//   }
// // }
// class UserRepo {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<MyUser?> fetchRegisteredUser(String userId) async {
//     try {
//       // Assuming you have a 'users' collection where each document has a 'userId' field
//       QuerySnapshot querySnapshot = await _firestore
//           .collection('users')
//           .where('userId', isEqualTo: userId)
//           .get();

//       if (querySnapshot.docs.isNotEmpty) {
//         // Assuming you want to get the first user with the specified ID
//         MyUser user = MyUser.fromMap(
//             querySnapshot.docs.first.data() as Map<String, dynamic>);
//         return user;
//       } else {
//         return null; // No user found with the specified ID
//       }
//     } catch (e) {
//       debugPrint('Error fetching user: $e');
//       return null;
//     }
//   }
// // }class UserRepo {
// final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

// User? get currentUser => _firebaseAuth.currentUser;

// Future<MyUser?> fetchRegisteredUser() async {
//   try {
//     // Check if there is a logged-in user
//     if (currentUser != null) {
//       // Assuming 'fetchRegisteredUser' method needs the user ID
//       QuerySnapshot querySnapshot = await _firestore
//           .collection('users')
//           .where('userId', isEqualTo: currentUser!.uid)
//           .get();

//       if (querySnapshot.docs.isNotEmpty) {
//         // Assuming you want to get the first user with the specified ID
//         MyUser user = MyUser.fromMap(
//             querySnapshot.docs.first.data() as Map<String, dynamic>);
//         return user;
//       } else {
//         return null; // No user found with the specified ID
//       }
//     } else {
//       // No logged-in user, return null or handle accordingly
//       return null;
//     }
//   } catch (e) {
//     debugPrint('Error fetching user: $e');
//     return null;
//   }
// }
