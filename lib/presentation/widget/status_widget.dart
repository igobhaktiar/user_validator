import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/user_controller.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget({
    super.key,
    required this.userController,
  });

  final UserController userController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: userController.status.value == 'Complete'
              ? Colors.greenAccent
              : Colors.orangeAccent,
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Text(
              '${userController.status.value} Profile',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            userController.status.value == 'Complete'
                ? const SizedBox()
                : Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                      color: userController.status.value == 'Complete'
                          ? Colors.greenAccent
                          : Colors.black.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      '!',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
