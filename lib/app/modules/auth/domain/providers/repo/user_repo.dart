import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:doc_appointment/app/modules/auth/domain/models/User_model.dart';

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

class UserRepo {
  final String id;
  final String username;
  final String email;

  UserRepo({
    required this.id,
    required this.username,
    required this.email,
  });

  UserRepo copyWith({
    String? id,
    String? username,
    String? email,
  }) {
    return UserRepo(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'username': username});
    result.addAll({'email': email});
  
    return result;
  }

  factory UserRepo.fromMap(Map<String, dynamic> map) {
    return UserRepo(
      id: map['id'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserRepo.fromJson(String source) => UserRepo.fromMap(json.decode(source));

  @override
  String toString() => 'UserRepo(id: $id, username: $username, email: $email)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserRepo &&
      other.id == id &&
      other.username == username &&
      other.email == email;
  }

  @override
  int get hashCode => id.hashCode ^ username.hashCode ^ email.hashCode;
}
class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<UserRepo>> fetchRegisteredUsers() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('users').get();
      List<UserRepo> userList = querySnapshot.docs
          .map((doc) => UserRepo.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      return userList;
    } catch (e) {
      debugPrint('Error fetching users: $e');
      return [];
    }
  }
}


// FutureBuilder<List<Map<String, dynamic>>>(
//         // Fetch admin information from Firestore
//         future: _fetchAdminsInformation(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             // Display admin information on the UI
//             List<Map<String, dynamic>> admins = snapshot.data!;

//             if (admins.isEmpty) {
//               return Center(child: Text('No admins found.'));
//             }

//             return ListView.builder(
//               itemCount: admins.length,
//               itemBuilder: (context, index) {
//                 String adminName = admins[index]['username'];
//                 String adminEmail = admins[index]['email'];

//                 return GestureDetector(
//                   onTap: () {
//                     // Handle the click event, for example, navigate to a detailed page
//                     context.pushNamed(MyNamedRoutes.muaDetails,
//                         extra: admins[index]);
//                   },
//                   child: Card(
//                     child: ListTile(
//                       title: Text(' $adminName'),
//                       subtitle: Text('Email: $adminEmail'),
//                     ),
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }

//   Future<List<Map<String, dynamic>>> _fetchAdminsInformation() async {
//     // Fetch information for all users with the role 'admin' from Firestore
//     QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
//         .instance
//         .collection('users')
//         .where('role', isEqualTo: 'isAdmin')
//         .get();

//     // Return a list of admin information
//     return querySnapshot.docs
//         .map((doc) => doc.data() as Map<String, dynamic>)
//         .toList();
//   }
// }
