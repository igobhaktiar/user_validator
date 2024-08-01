import 'dart:async';

import 'package:get/get.dart';
import 'package:user_validator/domain/entities/user.dart';
import 'package:user_validator/domain/repositories/user_repository.dart';
import 'package:user_validator/domain/usecases/username_validation_usecase.dart';

class UserController extends GetxController {
  final UserRepository userRepository;
  final UsernameValidationUseCase usernameValidationUseCase;

  var userName = ''.obs;
  var isUserNameAvailable = true.obs;
  var changeUserName = true.obs;
  var status = 'Incomplete'.obs;
  var isValidate = false.obs;
  var isLoading = false.obs;
  var userId = ''.obs;

  UserController({
    required this.userRepository,
    required this.usernameValidationUseCase,
  });

  void validateUsername(String input) {
    isValidate.value = usernameValidationUseCase.validateUsername(input);
  }

  Future<bool> checkUserNameAvailability(String userName) async {
    isUserNameAvailable.value =
        await userRepository.isUserNameAvailable(userName);
    return isUserNameAvailable.value;
  }

  Future<bool> canChangeUserName(String username) async {
    try {
      changeUserName.value = await userRepository.canChangeUserName(username);
      return changeUserName.value;
    } catch (e) {
      var canChange = changeUserName.value = true;
      return canChange;
    }
  }

  Future<void> updateUserName(String userId, newUsername) async {
    isLoading.value = true;
    try {
      await userRepository.updateUserName(userId, newUsername);
      var user = await _getUser(userId);
      _saveData(user!);
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  // add user
  Future<User> addUser(String name) async {
    isLoading.value = true;
    try {
      final user = await userRepository.addUser(name);
      userName.value = name;
      checkUserNameAvailability(userName.value);
      _saveData(user);
      _userStatus();
      isLoading.value = false;
      return user;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateUserReviewStatus(String userId, bool isReview) async {
    await userRepository.updateUserReviewStatus(userId, isReview);
  }

  Future<List<User>> getAllUsers() async {
    final users = await userRepository.getAllUsers();
    return users.where((user) => user != null).map((user) => user!).toList();
  }

  Future<void> _saveData(User user) async {
    await userRepository.saveData(user);
  }

  Future<void> getData() async {
    var user = await userRepository.getData();
    if (user != null) {
      userName.value = user.userName;
      userId.value = user.userId;
      canChangeUserName(userName.value);
    }
    status.value = _userStatus() ? 'Complete' : 'Incomplete';
  }

  Future<void> deleteUser(String userId) async {
    await userRepository.deleteUser(userId);
  }

  Future<void> clearData() async {
    await userRepository.clearData();
    var user = await userRepository.getData();
    userName.value = user?.userName ?? '';
    status.value = 'Incomplete';
    userId.value = '';
  }

  Future<User?> _getUser(String userId) async {
    return await userRepository.getUser(userId);
  }

  bool _userStatus() {
    if (userName.value == '') {
      return false;
    } else {
      return true;
    }
  }

  Future<void> updateReviewStatus(String userId, bool isReview) async {
    await userRepository.updateUserReviewStatus(userId, isReview);
  }
}
