import 'package:get/get.dart';
import 'package:user_validator/domain/entities/user.dart';
import 'package:user_validator/domain/repositories/user_repository.dart';
import 'package:user_validator/domain/usecases/username_validation_usecase.dart';

class UserController extends GetxController {
  final UserRepository userRepository;
  final UsernameValidationUseCase usernameValidationUseCase;

  var userName = ''.obs;
  var isUserNameAvailable = false.obs;
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
    userName.value = input;
    if (isValidate.value) {
      checkUserNameAvailability(input);
    }
  }

  Future<void> checkUserNameAvailability(String userName) async {
    isUserNameAvailable.value =
        await userRepository.isUserNameAvailable(userName);
    status.value = isUserNameAvailable.value ? 'Incomplete' : 'Complete';
  }

  Future<void> canChangeUserName(String userId) async {
    changeUserName.value =
        await userRepository.canChangeUserName(userId, userName.value);
  }

  Future<void> updateUserName(String userId) async {
    await userRepository.updateUserName(userId, userName.value);
  }

  Future<User> addUser(String userName) async {
    isLoading.value = true;
    try {
      final user = await userRepository.addUser(userName);
      await userRepository.saveData(user);
      userId.value = user.userId;
      isLoading.value = false;
      return user;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getUser(String userId) async {
    final user = await userRepository.getUser(userId);
    if (user != null) {
      userName.value = user.userName;
    }
  }

  Future<void> updateUserReviewStatus(String userId, bool isReview) async {
    await userRepository.updateUserReviewStatus(userId, isReview);
  }

  Future<List<User>> getAllUsers() async {
    final users = await userRepository.getAllUsers();
    return users.where((user) => user != null).map((user) => user!).toList();
  }

  Future<void> saveData(User user) async {
    await userRepository.saveData(user);
  }

  Future<User?> getData() async {
    var user = await userRepository.getData();
    if (user != null) {
      userName.value = user.userName;
    }
    return user;
  }

  Future<void> deleteUser(String userId) async {
    await userRepository.deleteUser(userId);
  }

  Future<void> clearData() async {
    await userRepository.clearData();
    var user = await userRepository.getData();
    userName.value = user?.userName ?? '';
    status.value = 'Incomplete';
  }
}
