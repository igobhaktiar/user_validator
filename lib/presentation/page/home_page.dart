import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_validator/data/repositories/user_repository_impl.dart';
import 'package:user_validator/domain/entities/user.dart';
import 'package:user_validator/domain/usecases/username_validation_usecase.dart';
import 'package:user_validator/presentation/controller/user_controller.dart';
import 'package:user_validator/presentation/page/user_validation.dart';
import '../../utils/colors.dart';
import '../widget/button_custom_widget.dart';
import '../widget/status_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserController userController = Get.put(
    UserController(
      userRepository: UserRepositoryImpl(
        FirebaseFirestore.instance,
      ),
      usernameValidationUseCase: UsernameValidationUseCase(),
    ),
  );

  User? user;
  String? username = 'User';

  @override
  void initState() {
    super.initState();
    _initController();
  }

  void _initController() async {
    user = await userController.getData();

    if (user != null) {
      userController.canChangeUserName(user!.userId);
      userController.checkUserNameAvailability(user!.userName);
    }

    setState(() {});
  }

  void _deleteAction(String userId) async {
    await userController.clearData();
    await userController.deleteUser(userId);
    _initController();
    Get.back();
    setState(() {});
  }

  void _initDelete() {
    Get.defaultDialog(
      title: 'Delete User',
      middleText: 'Are you sure want to delete this user?',
      textConfirm: 'Yes',
      textCancel: 'No',
      confirmTextColor: Colors.white,
      onConfirm: () {
        String userId;
        if (user != null) {
          userId = user!.userId;
        } else {
          userId = userController.userId.value;
        }
        _deleteAction(userId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      username = userController.userName.value;
      return _buildBody(userController);
    });
  }

  Widget _buildBody(UserController controller) {
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
        child: Column(
          children: [
            const SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        username == '' ? 'User' : username!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                StatusWidget(userController: controller),
              ],
            ),
            const SizedBox(height: 64),
            ButtonCustomWidget(
              text: 'Start',
              onPressed: () => Get.to(const UserValidation()),
            ),
            const SizedBox(height: 32),
            controller.userName.value == ''
                ? const SizedBox()
                : ButtonCustomWidget(
                    text: 'Delete',
                    color: Colors.redAccent,
                    onPressed: _initDelete,
                  ),
          ],
        ),
      ),
    );
  }
}
