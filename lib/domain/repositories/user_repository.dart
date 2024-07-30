import 'package:user_validator/domain/entities/user.dart';

abstract class UserRepository {
  // add user to firestore
  Future<bool> addUser(String username);

  // get user from firestore
  Future<User?> getUser(String userId);

  // update userName in firestore
  Future<void> updateUserName(String userId, String name);

  // is username available
  Future<bool> isUserNameAvailable(String name);

  // get all users from firestore
  Future<List<User?>> getAllUsers();

  // can change user name
  Future<bool> canChangeUserName(String userId, String name);

  // Update user review status
  Future<void> updateUserReviewStatus(String userId, bool isReview);
}
