import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_user.dart';

final usersProvider = FutureProvider<List<AppUser>>((ref) async {
  final snapshot = await FirebaseFirestore.instance.collection('users').get();
  return snapshot.docs
      .map((doc) => AppUser.fromFirestore(doc.data(), doc.id))
      .toList();
});
