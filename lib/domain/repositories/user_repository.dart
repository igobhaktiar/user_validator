import 'package:user_validator/domain/entities/user.dart';

abstract class UserRepository {
  // add user to firestore
  Future<User> addUser(String username);

  // get user from firestore
  Future<User?> getUser(String userId);

  // update userName in firestore
  Future<void> updateUserName(String userId, String name);

  // is username available
  Future<bool> isUserNameAvailable(String name);

  // get all users from firestore
  Future<List<User?>> getAllUsers();

  // can change user name
  Future<bool> canChangeUserName(String name);

  // Update user review status
  Future<void> updateUserReviewStatus(String userId, bool isReview);

  // save user data to shared preference
  Future<void> saveData(User user);

  // get user data from shared preference
  Future<User?> getData();

  // clear user data from shared preference
  Future<void> clearData();

  // delete user from firestore
  Future<void> deleteUser(String userId);
}
