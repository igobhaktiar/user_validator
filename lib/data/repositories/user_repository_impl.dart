import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_validator/data/source/local/sharedpreference_source.dart';
import 'package:user_validator/domain/entities/user.dart';

import '../../domain/repositories/user_repository.dart';
import '../source/remote/firestore_source.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore fireStore;

  UserRepositoryImpl(this.fireStore);

  @override
  Future<User> addUser(String userName) async {
    final source = FireStoreSource(fireStore);
    var user = await source.addUser(userName);
    return user;
  }

  @override
  Future<bool> canChangeUserName(String name) {
    final source = FireStoreSource(fireStore);
    return source.canChangeUserName(name);
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

  @override
  Future<void> saveData(User user) {
    return SharedPreferenceSource().saveData(user);
  }

  @override
  Future<User?> getData() {
    return SharedPreferenceSource().getData();
  }

  @override
  Future<void> clearData() {
    return SharedPreferenceSource().clearData();
  }

  @override
  Future<void> deleteUser(String userId) {
    final source = FireStoreSource(fireStore);
    return source.deleteUser(userId);
  }
}
