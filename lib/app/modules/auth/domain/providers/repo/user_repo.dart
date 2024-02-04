import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:doc_appointment/app/modules/auth/domain/models/User_model.dart';
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