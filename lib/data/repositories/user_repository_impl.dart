import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_validator/domain/entities/user.dart';

import '../../domain/repositories/user_repository.dart';
import '../source/remote/firestore_source.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore fireStore;

  UserRepositoryImpl(this.fireStore);

  @override
  Future<bool> addUser(String userName) {
    final source = FireStoreSource(fireStore);
    return source.addUser(userName);
  }

  @override
  Future<bool> canChangeUserName(String userId, String name) {
    final source = FireStoreSource(fireStore);
    return source.canChangeUserName(userId, name);
  }

  @override
  Future<List<User?>> getAllUsers() {
    final source = FireStoreSource(fireStore);
    return source.getAllUsers();
  }

  @override
  Future<User?> getUser(String userId) {
    final source = FireStoreSource(fireStore);
    return source.getUser(userId);
  }

  @override
  Future<bool> isUserNameAvailable(String name) {
    final source = FireStoreSource(fireStore);
    return source.isUserNameAvailable(name);
  }

  @override
  Future<void> updateUserName(String userId, String name) {
    final source = FireStoreSource(fireStore);
    return source.updateUserName(userId, name);
  }

  @override
  Future<void> updateUserReviewStatus(String userId, bool isReview) {
    final source = FireStoreSource(fireStore);
    return source.updateUserReviewStatus(userId, isReview);
  }
}
