import 'package:doc_appointment/app/modules/auth/domain/providers/repo/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final usersRepositoryProvider = Provider((ref) => UserRepository());

final usersProvider = FutureProvider.autoDispose<List<UserRepo>>((ref) async {
  final usersRepo = ref.watch(usersRepositoryProvider);
  debugPrint("*******");
  try {
    final userList = await usersRepo.fetchRegisteredUsers();
    return userList;
  } catch (e) {
    debugPrint('Error fetching users: $e');
    return [];
  }
});
