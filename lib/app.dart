import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/Bottom_Navigate.dart';
import 'widgets/home/Middle.dart' as _home;

import 'widgets/timetables/Timetables.dart';
import 'widgets/projects/Projects.dart';
import 'widgets/chat/Chat.dart';
import 'widgets/myinfo/Myinfo.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: BottomNavController.to.selectedIndex.value,
          children: [
            _home.Middle(),//home
            Timetables(),
            Projects(),//projects
            Chat(),
            Myinfo(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigate(),
    );
  }
}

