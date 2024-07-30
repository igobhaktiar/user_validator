import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_validator/data/repositories/user_repository_impl.dart';
import 'package:user_validator/domain/repositories/user_repository.dart';
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
  final UserRepository userRepository =
      UserRepositoryImpl(FirebaseFirestore.instance);
  final UsernameValidationUseCase usernameValidationUseCase =
      UsernameValidationUseCase();
  final UserController userController = Get.put(
    UserController(
      userRepository: UserRepositoryImpl(FirebaseFirestore.instance),
      usernameValidationUseCase: UsernameValidationUseCase(),
    ),
  );

  @override
  void initState() {
    super.initState();
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
        child: Column(
          children: [
            const SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 48,
                  width: 48,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                StatusWidget(userController: userController),
              ],
            ),
            const SizedBox(height: 64),
            ButtonCustomWidget(
              text: 'Start',
              onPressed: () => Get.to(const UserValidation()),
            ),
          ],
        ),
      ),
    );
  }
}
