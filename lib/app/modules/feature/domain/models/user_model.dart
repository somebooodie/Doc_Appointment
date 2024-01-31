import 'dart:convert';

import 'package:flutter/foundation.dart';

class MyUser {
  final String id;
  final String username;
  final String email;
  final String doctorId;

  MyUser({
    required this.id,
    required this.username,
    required this.email,
    required this.doctorId,
  });

  MyUser copyWith({
    String? id,
    String? username,
    String? email,
    String? doctorId,
  }) {
    return MyUser(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      doctorId: doctorId ?? this.doctorId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'username': username});
    result.addAll({'email': email});
    result.addAll({'doctorId': doctorId});

    return result;
  }

  factory MyUser.fromMap(Map<String, dynamic> map) {
    print("****** $map");
    try {
      return MyUser(
        id: map['id'] ?? '',
        username: map['username'] ?? '',
        email: map['email'] ?? '',
        doctorId: map['doctorId'] ?? '',
      );
    } catch (e) {
      throw e.toString();
    }
  }

  String toJson() => json.encode(toMap());

  factory MyUser.fromJson(String source) => MyUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MyUser(id: $id, username: $username, email: $email, doctorId: $doctorId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MyUser &&
        other.id == id &&
        other.username == username &&
        other.email == email &&
        other.doctorId == doctorId;
  }

  @override
  int get hashCode {
    return id.hashCode ^ username.hashCode ^ email.hashCode ^ doctorId.hashCode;
  }
}
