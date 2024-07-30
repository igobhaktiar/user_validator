import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_validator/presentation/controller/user_controller.dart';
import 'package:user_validator/presentation/widget/button_custom_widget.dart';
import 'package:user_validator/utils/colors.dart';

import '../../data/repositories/user_repository_impl.dart';
import '../../domain/usecases/username_validation_usecase.dart';
import '../widget/back_button_widget.dart';
import '../widget/status_widget.dart';
import '../widget/tf_custom_widget.dart';

class UserValidation extends StatefulWidget {
  const UserValidation({super.key});

  @override
  State<UserValidation> createState() => _UserValidationState();
}

class _UserValidationState extends State<UserValidation> {
  final UserController userController = Get.put(UserController(
    userRepository: UserRepositoryImpl(FirebaseFirestore.instance),
    usernameValidationUseCase: UsernameValidationUseCase(),
  ));

  final TextEditingController _usernameController = TextEditingController();

  bool? isValidate;
  bool? isUserNameAvailable;
  bool? changeUserName;
  bool? isLoading;
  String? availableText;
  String? changeText;

  @override
  void initState() {
    super.initState();
  }

  void _initController(UserController userController) async {
    isValidate = userController.isValidate.value;
    isUserNameAvailable = userController.isUserNameAvailable.value;
    changeUserName = userController.changeUserName.value;
    availableText = isUserNameAvailable! ? 'available' : 'unavailable';
    changeText = changeUserName! ? 'can' : 'can\'t';
    isLoading = userController.isLoading.value;
  }

  void _addUser() {
    if (isValidate! && isUserNameAvailable! && changeUserName!) {
      userController.addUser(_usernameController.text);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            transform: const GradientRotation(0.5),
            colors: [
              ColorsAsset.lightBlue2,
              Colors.deepPurpleAccent.shade100,
            ],
          ),
        ),
        child: Obx(() {
          _initController(userController);
          return Column(
            children: [
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BackButtonWidget(),
                  StatusWidget(userController: userController),
                ],
              ),
              const SizedBox(height: 32),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Username',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TfCustomWidget(
                          usernameController: _usernameController,
                          onChanged: (value) {
                            userController.validateUsername(value);
                          },
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '- Use characters and numbers only',
                                  style: TextStyle(
                                    color:
                                        isValidate! ? Colors.black : Colors.red,
                                  ),
                                ),
                                Text(
                                  '- Minimum 8 characters',
                                  style: TextStyle(
                                    color:
                                        isValidate! ? Colors.black : Colors.red,
                                  ),
                                ),
                                Text(
                                  '- This Username is $availableText',
                                  style: TextStyle(
                                    color: isUserNameAvailable!
                                        ? Colors.black
                                        : Colors.red,
                                  ),
                                ),
                                Text(
                                  '- You $changeText change your username',
                                  style: TextStyle(
                                    color: userController.changeUserName.value
                                        ? Colors.black
                                        : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: -28,
                    right: 32,
                    left: 32,
                    child: ButtonCustomWidget(
                      text: 'Confirm',
                      onPressed: _addUser,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              isLoading == true
                  ? const CircularProgressIndicator()
                  : const SizedBox(),
            ],
          );
        }),
      ),
    );
  }
}
