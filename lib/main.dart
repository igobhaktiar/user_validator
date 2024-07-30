import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_validator/firebase_options.dart';
import 'package:user_validator/presentation/page/home_page.dart';
import 'package:user_validator/presentation/page/user_validation.dart';
import 'package:user_validator/utils/route_name.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'User Validator',
      initialRoute: RouteName.home,
      getPages: [
        GetPage(
          name: RouteName.home,
          page: () => const HomePage(),
        ),
        GetPage(
          name: RouteName.userValidation,
          page: () => const UserValidation(),
        ),
      ],
    );
  }
}
