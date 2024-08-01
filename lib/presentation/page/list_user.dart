import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_validator/presentation/widget/back_button_widget.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/username_validation_usecase.dart';
import '../../utils/colors.dart';
import '../controller/user_controller.dart';
import '../widget/icon_button_custom_widget.dart';

class ListUsers extends StatefulWidget {
  const ListUsers({super.key});

  @override
  State<ListUsers> createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {
  final UserController userController = Get.put(
    UserController(
      userRepository: UserRepositoryImpl(
        FirebaseFirestore.instance,
      ),
      usernameValidationUseCase: UsernameValidationUseCase(),
    ),
  );

  List<User>? listUsers;

  @override
  void initState() {
    super.initState();
  }

  void _initController() async {
    listUsers = await userController.getAllUsers();
    listUsers?.sort((a, b) => a.userName.compareTo(b.userName));
    setState(() {});
  }

  void _onCheckAction(String userId, bool? isReview) async {
    var updateStatus = isReview == true ? false : true;
    userController.updateReviewStatus(userId, updateStatus);
    _initController();
    setState(() {});
  }
  void _onDeleteAction(String userId) {
    Get.defaultDialog(
      title: 'Delete User',
      middleText: 'Are you sure want to delete this user?',
      textConfirm: 'Yes',
      textCancel: 'No',
      confirmTextColor: Colors.white,
      onConfirm: () {
        userController.deleteUser(userId);
        Get.back();
      },
      onCancel: () {
        Get.back();
      },
    );
    _initController();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _initController();
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
        child: _buildBody(userController),
      ),
    );
  }

  Widget _buildBody(UserController controller) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Row(
          children: [
            const BackButtonWidget(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text(
                'List Users',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Expanded(
          child: ListView.builder(
            itemCount: listUsers?.length,
            itemBuilder: (context, index) {
              final user = listUsers?[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text(
                          user?.userName ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        IconButtonCustomWidget(
                          onPressed: () => _onCheckAction(
                              user?.userId ?? '', user?.isReview),
                          color: user?.isReview == true
                              ? Colors.green
                              : Colors.orangeAccent,
                          icon: Icons.check,
                        ),
                        const SizedBox(width: 8),
                        IconButtonCustomWidget(
                          onPressed: () => _onDeleteAction(user?.userId ?? ''),
                          color: Colors.red,
                          icon: Icons.delete,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
