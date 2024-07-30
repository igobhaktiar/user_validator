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

  Future<void> addUser(String userName) async {
    isLoading.value = true;
    var added = await userRepository.addUser(userName);
    if (added) {
      checkUserNameAvailability(userName);
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
}
