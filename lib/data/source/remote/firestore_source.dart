import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_validator/domain/entities/user.dart';

class FireStoreSource {
  final FirebaseFirestore fireStore;

  FireStoreSource(this.fireStore);

  Future<bool> addUser(String userName) async {
    var id = fireStore.collection('users').doc().id;
    await fireStore.collection('users').doc(id).set({
      'userId': id,
      'userName': userName,
      'isReview': false,
    });

    return true;
  }

  Future<User?> getUser(String userId) async {
    var user = await fireStore.collection('users').doc(userId).get();
    if (user.exists) {
      return User(
        userId: user.data()?['userId'],
        userName: user.data()?['userName'],
        isReview: user.data()?['isReview'],
      );
    }
    return null;
  }

  Future<void> updateUserName(String userId, String name) async {
    await fireStore.collection('users').doc(userId).update({
      'userName': name,
    });
  }

  Future<bool> isUserNameAvailable(String name) async {
    var user = await fireStore
        .collection('users')
        .where('userName', isEqualTo: name)
        .get();
    return user.docs.isEmpty;
  }

  Future<List<User?>> getAllUsers() async {
    var users = await fireStore.collection('users').get();
    return users.docs
        .map((e) => User(
              userId: e.data()['userId'],
              userName: e.data()['userName'],
              isReview: e.data()['isReview'],
            ))
        .toList();
  }

  Future<bool> canChangeUserName(String userId, String name) async {
    final DocumentSnapshot userDoc =
        await fireStore.collection('users').doc(userId).get();
    return userDoc['isReview'] == false;
  }

  Future<void> updateUserReviewStatus(String userId, bool isReview) async {
    await fireStore.collection('users').doc(userId).update({
      'isReview': isReview,
    });
  }

  Future<void> deleteUser(String userId) async {
    await fireStore.collection('users').doc(userId).delete();
  }
}
