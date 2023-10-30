import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'old/Top.dart' as Top;
import 'widgets/home/Middle.dart' as Middle;
import 'old/Bottom.dart' as Bottom;
import 'widgets/Bottom_Navigate.dart';
import 'widgets/projects/Projects.dart';
import 'app.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await initializeDateFormatting();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override

  Widget build(BuildContext context) {

    return GetMaterialApp( //
      title: 'Kroocrew',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: App(),
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






