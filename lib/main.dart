import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/Bottom_Navigate.dart';
import 'app.dart';
import 'screens/login/login.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:go_router/go_router.dart';

import '/screens/home/home_main.dart';
import '/screens/timetables/Timetables.dart';
import '/screens/projects/Projects.dart';
import '/screens/chat/Chat.dart';
import '/screens/myinfo/Myinfo.dart';



void main() async {
  await initializeDateFormatting();
  runApp(MyApp());
}

class LoginController extends GetxController {
  var log_in = false.obs;

  void loginAcc() {
    Future.microtask(() {
      log_in.value = true;
    });
  }
  void loginDacc() {
    Future.microtask(() {
      log_in.value = false;
    });
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());

    return GetMaterialApp(
      title: 'Kroocrew',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'NanumSqareRound',
      ),
      themeMode: ThemeMode.system,
      home: Obx(() =>
        loginController.log_in.value ? App(loginDacc: loginController.loginDacc) : login(loginAcc: loginController.loginAcc),
      ),
      initialBinding: InitBinding(),
    );
  }
}

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavController());
  }
}
