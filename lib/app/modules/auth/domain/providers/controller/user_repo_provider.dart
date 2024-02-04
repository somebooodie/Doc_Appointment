import 'package:doc_appointment/app/modules/auth/domain/models/User_model.dart';
import 'package:doc_appointment/app/modules/auth/domain/providers/repo/auth_repo.dart';
//import 'package:doc_appointment/app/modules/feature/domain/providers/repo/user_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRepoProvider =
    Provider((ref) => AuthRepository(FirebaseAuth.instance));

final userProvider = FutureProvider.autoDispose<User?>((ref) async {
  final userRepo = ref.watch(userRepoProvider);

  try {
    final currentUser = userRepo.currentUser;

    // Check if there is a logged-in user
    if (currentUser != null) {
      // Assuming 'fetchRegisteredUsers' method needs the user ID
      final userList = await userRepo.fetchUserById(currentUser.uid.toString());

      // Assuming you want the first user in the list
      // final user = userList.isNotEmpty ? userList.first : null;
    //final user = userList?.isNotEmpty ?? false ? userList!.first : null;
     // return user;
    } else {
      // No logged-in user, return null or handle accordingly
      return null;
    }
  } catch (e) {
    debugPrint('Error fetching user: $e');
    return null;
  }
});
